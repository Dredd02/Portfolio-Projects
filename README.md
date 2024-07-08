COVID-19 Data Analysis with SQL

This repository contains SQL scripts for analyzing COVID-19 data, focusing on various aspects such as death rates, vaccination rates, and country-specific statistics. The data is sourced from two primary tables: CovidDeaths and CovidVaccinations in the SqlPortfolioProject database.

SQL Scripts Overview
Basic Data Retrieval:

Queries to fetch all records from CovidDeaths and CovidVaccinations tables, ordered by relevant columns.
Lesotho COVID-19 Data Analysis:

Calculate the death rate percentage for Lesotho.
Determine the percentage of the Lesotho population that contracted the COVID-19 virus.
Global Analysis:

Identify countries with the highest death count per population.
Using a Common Table Expression (CTE) to show the cumulative number of people vaccinated and the percentage of the population vaccinated for each location.
Temporary Table Usage:

Create and populate a temporary table PopulationVaccinatedPercentage to store vaccination data and calculate the percentage of the population vaccinated.
Views Creation:

Create a view PopulationVaccinationPercentagee to show the vaccinated population by percentage.
Create a view LsPercentage to show the percentage of the Lesotho population that contracted the COVID-19 virus.
Table Descriptions
CovidDeaths:

Contains data related to COVID-19 cases and deaths across various locations and dates.
CovidVaccinations:

Contains data related to COVID-19 vaccinations across various locations and dates.
