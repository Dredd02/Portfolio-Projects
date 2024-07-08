
-- Retrieve all records from CovidDeaths table
SELECT * 
FROM SqlPortfolioProject..CovidDeaths
ORDER BY 3, 4;

-- Retrieve all records from CovidVaccinations table
SELECT * 
FROM SqlPortfolioProject..CovidVaccinations
ORDER BY 3, 4;

-- Retrieve Lesotho COVID-19 Data and Death Rate Calculation
-- Shows chances of mortality if the COVID-19 virus is contracted
SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths, 
    (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS DeathPercentage
FROM SqlPortfolioProject..CovidDeaths 
WHERE location LIKE '%lesotho%'
ORDER BY location, date;

-- Shows the percentage of Lesotho population that contracted COVID-19 virus
SELECT 
    location, 
    date, 
    population, 
    total_cases, 
    (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS CovidContactPercentage
FROM SqlPortfolioProject..CovidDeaths 
WHERE location LIKE '%lesotho%'
ORDER BY location, date;

-- Shows countries with the highest death count per population
SELECT 
    location, 
    MAX(CONVERT(int, total_deaths)) AS TotalDeathCount
FROM SqlPortfolioProject..CovidDeaths 
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Shows cumulative number of people vaccinated and percentage of population vaccinated for each location using CTE
WITH PopVac AS (
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
    FROM SqlPortfolioProject..CovidDeaths dea
    JOIN SqlPortfolioProject..CovidVaccinations vac 
        ON dea.location = vac.location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *,
    CASE 
        WHEN population = 0 THEN NULL
        ELSE (CAST(PeopleVaccinated AS decimal) / population) * 100  
    END AS PercentageVaccinated
FROM PopVac;

-- TEMP TABLE
IF OBJECT_ID('db0.PopulationVaccinatedPercentage') IS NOT NULL
    DROP TABLE PopulationVaccinatedPercentage;

CREATE TABLE PopulationVaccinatedPercentage (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    PeopleVaccinated NUMERIC
);

INSERT INTO PopulationVaccinatedPercentage
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM SqlPortfolioProject..CovidDeaths dea
JOIN SqlPortfolioProject..CovidVaccinations vac 
    ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT *,
    CASE 
        WHEN population = 0 THEN NULL
        ELSE (CAST(PeopleVaccinated AS decimal) / population) * 100  
    END AS PercentageVaccinated
FROM PopulationVaccinatedPercentage;

USE SqlPortfolioProject;
GO

-- View for vaccinated population by percentage
CREATE VIEW PopulationVaccinationPercentagee AS
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER 
        (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM SqlPortfolioProject..CovidDeaths dea
JOIN SqlPortfolioProject..CovidVaccinations vac 
    ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
GO

SELECT * 
FROM PopulationVaccinationPercentagee;

USE SqlPortfolioProject;
GO

CREATE VIEW LsPercentage AS
SELECT 
    location, 
    date, 
    population, 
    total_cases, 
    (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS CovidContactPercentage
FROM SqlPortfolioProject..CovidDeaths 
WHERE location LIKE '%lesotho%'
ORDER BY location, date;
GO

SELECT * 
FROM PopulationVaccinationPercentagee;
```

This structure ensures your SQL code is clear, well-documented, and ready for others to understand and use when you upload it to GitHub.