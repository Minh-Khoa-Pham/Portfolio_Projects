SELECT *
FROM PortfolioProject..CovidDeaths$
--WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations$
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2


--Show death percentage in a country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM PortfolioProject..CovidDeaths$
WHERE location LIKE 'Viet%' AND continent IS NOT NULL
ORDER BY 1,2


-- Show population infected percentage in a country
SELECT location, date, total_cases, population, (total_cases/population)*100 as population_infected_percentage
FROM PortfolioProject..CovidDeaths$
WHERE location LIKE 'Viet%' AND continent IS NOT NULL
ORDER BY 1,2


--Show highest infected rate by country
SELECT location, MAX(total_cases) as highest_total_cases, population, MAX(total_cases/population)*100 as population_infected_percentage
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY population_infected_percentage DESC


--Show highest total deaths by country
SELECT location, MAX(CAST(total_deaths as int)) as highest_total_deaths
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY highest_total_deaths DESC

--Show highest total deaths by a country in each continent
SELECT continent, MAX(CAST(total_deaths as int)) as highest_total_deaths
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_total_deaths DESC


--GLOBQL NUMBERS	

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_percentage
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2


--Show total population vs vaccinations

--Use CTE
With PopvsVac (continent, location, date, population, new_vaccinations, rolling_vaccinations)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location
ORDER BY dea.location, dea.date) as rolling_vaccinations
--,(rolling_vaccinations/population)*100
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (rolling_vaccinations/population)*100 as vaccinated_percentage
FROM PopvsVac


--TEMP TABLE

DROP TABLE IF exists #PercentPopulationVaccinated
CREATE TABLE  #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_vaccinations numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location
ORDER BY dea.location, dea.date) as rolling_vaccinations
--,(rolling_vaccinations/population)*100
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (rolling_vaccinations/population)*100 as vaccinated_percentage
FROM #PercentPopulationVaccinated


--Create view to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location
ORDER BY dea.location, dea.date) as rolling_vaccinations
--,(rolling_vaccinations/population)*100
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccinated