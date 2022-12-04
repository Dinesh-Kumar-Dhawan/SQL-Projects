create database portfolioprojectNew;
use portfolioprojectNew;

select * from coviddeathsnew;
select count(*) from coviddeathsnew;

select * from covidvacinationnew;
select count(*) from covidvacinationnew;


-- looking at total cases vs total deaths by location

select location, population, date, max(total_cases) as total_case, max(total_deaths) as total_death
from coviddeathsnew
group by location; 

-- looking at infection rate and death rate over population

select location, population, max(total_cases) as total_case,  
max(total_deaths) as total_death, (max(total_cases)/population)*100 as infection_rate,
(max(total_deaths)/max(total_cases))*100 as death_rate
from coviddeathsnew
group by location; 

-- looking fror top 10 most infected countries

select location, population, max(total_cases) as total_case,  
max(total_deaths) as total_death, (max(total_cases)/population)*100 as infection_rate,
(max(total_deaths)/max(total_cases))*100 as death_rate
from coviddeathsnew
group by location
order by infection_rate desc
limit 10; 

-- looking for heighest death rate countries

select location, population, max(total_cases) as total_case,  
max(total_deaths) as total_death, (max(total_cases)/population)*100 as infection_rate,
(max(total_deaths)/max(total_cases))*100 as death_rate
from coviddeathsnew
group by location
order by death_rate desc
limit 10; 

-- looking for total cases, total deaths, infected population perscent and death rate over infection, 
-- and death perscent over population in india

select location, population, max(total_cases) as total_case,  
max(total_deaths) as total_death, (max(total_cases)/population)*100 as infection_rate,
(max(total_deaths)/max(total_cases))*100 as death_rate_over_infection, 
(max(total_deaths)/population)*100 as death_perscent_over_population
from coviddeathsnew
where location="india"
group by location;

-- looking for total cases and death at the end of march in india

select location, population, date, total_cases, total_deaths
from coviddeathsnew
where location="india" and date="31-03-2020";

-- looking at global numbers over date

select date, sum(total_cases) as global_cases, sum(total_deaths) as global_deaths
from coviddeathsnew
group by date;

-- looking at global numbers

select sum(population) as global_population, sum(total_case) as global_cases, sum(total_death) as global_deaths
from
(select location, population, max(total_cases) as total_case, max(total_deaths) as total_death
from coviddeathsnew
group by location) as A;

select * from covidvacinationnew;
select count(*) from covidvacinationnew;

-- joining the tables coviddeathsnew and covidvacinationnew

select* from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date;

-- looking at population vs vaccination per day

select D.continent,D.location,D.date,D.population,V.total_vaccinations from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date
where D.continent is not null;

-- looking at population vs total_vaccination_perscent over location

select D.continent,D.location,D.date,D.population, max(V.total_vaccinations), 
(max(V.total_vaccinations)/D.population)*100 as vaccinated_population_perscent
from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date
group by D.location;

-- create view for later visualization

create view population_VS_vaccination as
select D.continent,D.location,D.date,D.population, max(V.total_vaccinations), 
(max(V.total_vaccinations)/D.population)*100 as vaccinated_population_perscent
from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date
group by D.location;

select * from population_VS_vaccination;

-- looking for top 10 highly vaccinated countries over the world

select D.continent, D.location, D.population, max(V.total_vaccinations) as count_vaccinations, 
max(V.people_vaccinated) as vaccinated_population_count, 
(max(V.people_vaccinated)/D.population)*100 as vaccinated_population_perscent
from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date
group by D.location
order by vaccinated_population_perscent desc
limit 10;

-- looking for the population, total vaccinations and vaccinated pepole in Gibraltar

select D.continent, D.location, D.population, max(V.total_vaccinations),
max(V.people_vaccinated)
from coviddeathsnew as D inner join covidvacinationnew as V
on D.location=V.location and D.date=V.date
where D.location="gibraltar"
group by D.location;







