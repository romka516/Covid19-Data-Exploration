# COVID-19 Data Exploration

This project focuses on analyzing COVID-19 data using PostgreSQL and two CSV files obtained from the Our World in Data website (https://ourworldindata.org/covid-deaths). The CSV files were divided into two parts: one containing general COVID-19 cases and deaths, and the other containing COVID-19 vaccination data. The inspiration for this project came from the "Alex the Analyst" YouTube channel.

## Project Overview

The main objective of this project is to explore the COVID-19 data and gain insights using PostgreSQL. The data exploration includes analyzing the relationship between COVID-19 cases, deaths, and vaccination rates. The project involves the following steps:

1. Downloaded the COVID-19 data in CSV format from the Our World in Data website.
2. Divided the CSV file into two separate files: one for COVID-19 cases and deaths, and the other for COVID-19 vaccination data.
3. Utilized PostgreSQL for data analysis, both individually for each file and by performing INNER JOIN operations on the two files.
4. Explored various aspects of the data, such as daily cases and deaths, vaccination rates by country, and correlations between cases, deaths, and vaccination rates.

## Files and Directory Structure

The project repository contains the following files:

- `CovidDeaths.csv`: CSV file containing COVID-19 cases and deaths data
- `CovidVaccinations.csv`: CSV file containing COVID-19 vaccination data
- `sql_codes.sql`: SQL script for performing data exploration on COVID-19 cases, deaths and vaccination data

## Acknowledgements

This project is inspired by the "Alex the Analyst" YouTube channel. Special thanks to the team at Our World in Data for providing the COVID-19 data for analysis.

## License

This project is licensed under the [MIT License](LICENSE).

