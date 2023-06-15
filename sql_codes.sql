-- Create table "coviddeaths" to store COVID-19 death data

CREATE TABLE coviddeaths (
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    date DATE,
    population FLOAT,
    total_cases FLOAT,
    new_cases FLOAT,
    new_cases_smoothed FLOAT,
    total_deaths FLOAT,
    new_deaths FLOAT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients FLOAT,
    icu_patients_per_million FLOAT,
    hosp_patients FLOAT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions FLOAT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions FLOAT,
    weekly_hosp_admissions_per_million FLOAT
);

-- The "CovidDeaths.csv" file has been successfully imported into the "coviddeaths" table

-- Create table to store COVID-19 vaccination data

CREATE TABLE covidvaccinations (
	iso_code TEXT,
	continent TEXT,
	location TEXT,
	date DATE,
	population NUMERIC,
	total_tests NUMERIC,
	new_tests NUMERIC,
	total_tests_per_thousand NUMERIC,
	new_tests_per_thousand NUMERIC,
	new_tests_smoothed NUMERIC,
	new_tests_smoothed_per_thousand NUMERIC,
	positive_rate NUMERIC,
	tests_per_case NUMERIC,
	tests_units TEXT,
	total_vaccinations NUMERIC,
	people_vaccinated NUMERIC,
	people_fully_vaccinated NUMERIC,
	total_boosters NUMERIC,
	new_vaccinations NUMERIC,
	new_vaccinations_smoothed NUMERIC,
	total_vaccinations_per_hundred NUMERIC,
	people_vaccinated_per_hundred NUMERIC,
	people_fully_vaccinated_per_hundred NUMERIC,
	total_boosters_per_hundred NUMERIC,
	new_vaccinations_smoothed_per_million NUMERIC,
	new_people_vaccinated_smoothed NUMERIC,
	new_people_vaccinated_smoothed_per_hundred NUMERIC,
	stringency_index NUMERIC,
	population_density NUMERIC,
	median_age NUMERIC,
	aged_65_older NUMERIC,
	aged_70_older NUMERIC,
	gdp_per_capita NUMERIC,
	extreme_poverty NUMERIC,
	cardiovasc_death_rate NUMERIC,
	diabetes_prevalence NUMERIC,
	female_smokers NUMERIC,
	male_smokers NUMERIC,
	handwashing_facilities NUMERIC,
	hospital_beds_per_thousand NUMERIC,
	life_expectancy NUMERIC,
	human_development_index NUMERIC,
	excess_mortality_cumulative_absolute NUMERIC,
	excess_mortality_cumulative NUMERIC,
	excess_mortality NUMERIC,
	excess_mortality_cumulative_per_million NUMERIC
);

-- The "CovidVaccinations.csv" file has also been successfully imported into the "covidvaccinations" table

-- The columns that I will be focusing on are as follows in coviddeaths table:

SELECT location, date, total_cases, population, new_cases, total_deaths
FROM coviddeaths;

-- Looking at Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths,
CAST((total_deaths / total_cases) * 100 AS INTEGER) AS
deathpercentage 
FROM coviddeaths;

/*It seems that the database I am using does not have a version of the ROUND function that accepts a 
double precision (floating-point) number as the first argument and an integer as the second argument. 
I've used the CAST function to convert the result of (total_deaths / total_cases) * 100 into an integer. 
This effectively achieves rounding to the nearest whole number without using the ROUND function with an explicit precision argument.*/

-- Looking at Total Cases vs Total Deaths only for USA

SELECT location, date, total_cases, total_deaths,
CAST((total_deaths / total_cases) * 100 AS INTEGER) AS
deathpercentage FROM coviddeaths
WHERE location ILIKE '%states%'
	AND total_deaths IS NOT NULL
ORDER BY DATE;

/*In the table output, the total number of COVID-19 cases is being recorded. As we reach the end of the table, approximately 103.5 million Americans 
have been infected since the emergence of the coronavirus until June 7th of 2023. Around one percent of this figure has died.
Now, let's look at for Turkey. */

SELECT location, date, total_cases, total_deaths,
CAST((total_deaths / total_cases) * 100 AS INTEGER) AS
deathpercentage FROM coviddeaths
WHERE location ILIKE '%turkey%' 
	AND total_deaths IS NOT NULL
ORDER BY DATE DESC LIMIT 1;

-- In Turkey, approximately 17 million people have been infected with the coronavirus. And around one percent of those infected have died

-- Looking at Total Cases vs Population for Turkey

    SELECT location, date, total_cases, population,
    CAST((total_cases / population) * 100 AS INTEGER) AS
    casepercentage FROM coviddeaths
    WHERE location ILIKE '%turkey%' 
		AND total_deaths IS NOT NULL
    ORDER BY DATE DESC LIMIT 1;

-- 20 percent of the population have been infected in Turkey until June 7th of 2023.(Consider that individual can be infected more than once!)

-- Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS max_total_case_per_country,
MAX(CAST((total_cases / population) * 100 AS INTEGER)) AS casepercentage 
FROM coviddeaths 
WHERE total_cases IS NOT NULL
GROUP BY location, population
ORDER BY casepercentage DESC;

/* "Cyprus," "San Marino," "Brunei," "Austria," and the "Faeroe Islands" are the countries with the highest infection rates based on their population. 
Cyprus is ranked first with a rate of 74 percent until June 7th 2023. */

-- Showing Countries with Highest Death Count per Population

SELECT location, population, MAX(total_deaths) AS max_total_death_per_country
FROM coviddeaths 
WHERE total_deaths IS NOT NULL 
	AND continent IS NOT NULL
GROUP BY location, population 
ORDER BY max_total_death_per_country DESC;

/*The countries with the highest number of deaths due to COVID-19 are the "United States," "Brazil," "India," "Russia," and "Mexico", respectively.
Based on the provided data, approximately 1.1 million people have died in the United States, 
making it the country with the highest number of COVID-19-related deaths worldwide. */

-- Let's analyze the data by grouping it based on continents.

SELECT location, MAX(total_cases) AS max_total_case_per_country 
FROM coviddeaths
WHERE location != 'World' 
	AND location NOT ILIKE '%income%'
	AND location NOT ILIKE '%union%'
GROUP BY location
HAVING MAX(total_cases) IS NOT NULL
ORDER BY max_total_case_per_country DESC;

-- Asia, Europe, and North America are the continents that have encountered the highest number of COVID-19 cases, respectively

-- Identifying the days with the highest number of COVID-19 cases globally.

SELECT date, MAX(new_cases) AS max_cases_per_day 
FROM coviddeaths
GROUP BY date
HAVING MAX(new_cases) IS NOT NULL
ORDER BY max_cases_per_day DESC;

-- December 23, 2023, is the day with the highest number of recorded COVID-19 cases, with approximately 8 million cases reported.

-- Identifying the days with the highest number of COVID-19 based deaths globally.

SELECT date, MAX(new_deaths) AS max_deaths_per_day 
FROM coviddeaths
GROUP BY date
HAVING MAX(new_deaths) IS NOT NULL
ORDER BY max_deaths_per_day DESC;

--On July 7, 2021, a total of approximately 20,000 deaths attributed to COVID-19 were recorded.

-- Identifying the days with the highest number of COVID-19 based deaths in Turkey.

SELECT date, MAX(new_deaths) AS max_deaths_per_day 
FROM coviddeaths
WHERE location = 'Turkey'
GROUP BY date, location
HAVING MAX(new_deaths) IS NOT NULL
ORDER BY max_deaths_per_day DESC;

-- May 1, 2021, is the day with the highest number of COVID-19 related deaths in Turkey, with 394 recorded deaths.

-- Looking at Total Population vs Vaccinations 

SELECT cd.continent, cd.location, cd.date, cd.population,
cv.new_vaccinations, SUM(CAST(new_vaccinations AS INT)) 
OVER (PARTITION BY cv.location
	  ORDER BY cv.location,
	  cv.date)
AS rollingpeoplevaccinated
FROM coviddeaths AS cd
INNER JOIN covidvaccinations AS cv
ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
	AND new_vaccinations IS NOT NULL;

/* In summary, the SQL code combines data from the coviddeaths and covidvaccinations tables, 
calculates the rolling sum of new vaccinations for each location, and returns the specified columns in the result set. */

-- Creating virtual table of vaccinations versus population

-- Looking at Total Population vs Vaccinations 

CREATE VIEW popvsvac AS 

SELECT cd.continent, cd.location, cd.date, cd.population,
cv.new_vaccinations, SUM(CAST(new_vaccinations AS INT)) 
OVER (PARTITION BY cv.location
	  ORDER BY cv.location,
	  cv.date)
AS rollingpeoplevaccinated
FROM coviddeaths AS cd
INNER JOIN covidvaccinations AS cv
ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
	AND new_vaccinations IS NOT NULL;

-- Looking at the vaccination percentage over time based on population.

SELECT *, (rollingpeoplevaccinated / population) * 100 AS vacpercentbytime
FROM popvsvac;

/* However, since individuals can receive multiple doses of a vaccine (2, 3, or even 4 doses depending on the vaccination protocol), 
the resulting data may not accurately reflect the actual vaccination percentage among the population over time. */