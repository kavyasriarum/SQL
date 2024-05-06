select *
from public.encounters
where encounterclass = 'inpatient'

select *
from public.encounters
where encounterclass = 'inpatient'
and description = 'ICU Admission'
and stop between '2023-01-01 00:00' and '2023-12-31 23:59'

select description,
count (*) as count_of_cond
from public.conditions 
where description != 'Body Mass Index 30.0-30.9, adult'
group by description
having count(*) >5000
order by count(*) desc

select *
from public.patients
where city = 'Boston'

-- gives me the patients with cronic kidney diseases, stage III and by the specific code
	
SELECT *
FROM public.conditions
WHERE description = 'Chronic kidney disease, Stage III (moderate)'
AND code IN ('585.1', '585.2', '585.3', '585.4');


--Write a query that does the following:
-- 1. Lists out number of patients per city in desc order
-- 2. does not include boston
-- 3. must have at least 100 patients from that city
-----------------------------------------------------
-- This query, gives me the count of all patients from their city of residence 
-- and there must have been at least 100 patients 
--cities do agt include Boston
-----------------------------------------------------
SELECT city, count(*) 
FROM public.patients
where city != 'Boston'
group by city
having count(*) >= 100
order by count(*) desc


-- joins 

select t1.*,
	t2.first,
	t2.last,
	t2.birthdate
from public.immunizations as t1
left join public.patients as t2	
on t1.patient =t2.id

	   



