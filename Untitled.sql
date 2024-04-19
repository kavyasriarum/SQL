-- DATA CLEANING


SELECT *
FROM layoffs;

-- STEP 1 - Removing Duplicates
-- STEP 2 - Standardize the Data
-- STEP 3 - Null or Blank Values
-- STEP 4 - Remove columns if not needed


CREATE TABLE Layoffs_staging
LIKE Layoffs;

SELECT *
from layoffs_staging;

INSERT Layoffs_staging
SELECT *
FROM layoffs;

-- STEP 1 Removing duplicates (we will do row number for all the coloumns and remove the duplicates )

SELECT *,
ROW_NUMBER() OVER(       -- function is used to assign a unique sequential integer to each row within a partition of the result set.
PARTITION BY company, industry, total_laid_off, percentage_laid_off, date) AS row_num
FROM Layoffs_staging;


WITH duplicate_cte as
(
SELECT *,
ROW_NUMBER() OVER(       -- function is used to assign a unique sequential integer to each row within a partition of the result set.
PARTITION BY company, industry, total_laid_off, percentage_laid_off, date) AS row_num
FROM Layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

-- NO DUPLICATES AVILABLE (If you have duplicate rows, duplicate the table and add the row_num in the table and run the delete statment
/* DELETE 
	FROM layoffs_staging2 
    WHERE row_num >1;
    */


CREATE TABLE `Layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM Layoffs_staging2;

INSERT INTO Layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(       -- function is used to assign a unique sequential integer to each row within a partition of the result set.
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
FROM Layoffs_staging;


-- step 2 - Standardizing Data  -> Finding issues in Data and fixing it

SELECT company, trim(company)
FROM Layoffs_staging2;

-- now to update the company from the trim(company) as it is filtered we need to run the below code

UPDATE layoffs_staging2
SET company = trim(company);

SELECT DISTINCT industry
FROM Layoffs_staging2
ORDER BY 1;

-- i dont hav e any updates to make, if you find run the below code 
/* SET industry = 'crypto'
WHERE industry LIKE 'crypto%'; */ 


SELECT DISTINCT location
FROM Layoffs_staging2
ORDER BY 1;

SELECT distinct country, TRIM(TRAILING '.' FROM Country) -- Trailing can remove the '.' from the end 
FROM Layoffs_staging2
ORDER by 1;

UPDATE Layoffs_staging2
SET Country = TRIM(TRAILING '.' FROM Country)
WHERE Country LIKE 'United States%';


-- we need to change the date column from text to DATA 

SELECT date,
str_to_date(date, '%m/%d/%Y')  -- it need to pass 2 parameters, date and (m/d/y)
FROM Layoffs_staging2;

UPDATE Layoffs_staging2
SET DATE = str_to_date(date, '%m/%d/%Y'); 


-- NOW CHANGE TO DATE COLUMN 

alter table Layoffs_staging2
MODIFY COLUMN `date` DATE;


SELECT *
FROM Layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- checking industry missing and NULL values 

UPDATE Layoffs_staging2
SET industry = null 
WHERE industry = '';

SELECT *
FROM Layoffs_staging2
where industry IS NULL;

SELECT *
FROM Layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- as we can see we are missing industry for the airbnb, we can check the indutry of airbnb and update the code 

SELECT *
FROM Layoffs_staging2;
UPDATE Layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb' AND industry = '';

SELECT *
FROM Layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM Layoffs_staging2 t1
JOIN Layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry is NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE Layoffs_staging2 t1
JOIN Layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry is NULL 
AND t2.industry is NOT NULL;
 
-- check this out  
UPDATE Layoffs_staging2
SET industry = 'Corporation'
WHERE company = 'Bally%' AND industry IS NULL;

-- NOW FIX THE total_laid_off and percentage_laid_off (you can delete this data because tehre are no layoffs)
SELECT *
FROM Layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM Layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- DROP THE ROW_NUM AS WE DONT NEED IT ANYMORE 

SELECT *
FROM Layoffs_staging2;

ALTER table Layoffs_staging2
drop column row_num;

