-- Loading Data 
create database if not exists Healthcare;

use Healthcare;

select * from diabetic_data;


/*
Tasks:
1. Calculate the total number of patient encounters in the healthcare dataset.
2. Identify the top 10 most frequent diagnoses in the dataset.
3. Calculate the average length of hospital stay for each admission type.
4. Determine the number of readmitted patients and the percentage of total
encounters that they represent.
5. Identify the age distribution of patients.
6. Identify the most common procedures performed during patient encounters.
7. Calculate the average number of medications prescribed for patients in each age
group.
8. Identify the distribution of readmission rates across different payer codes.
*/

-- 1. Calculate the total number of patient encounters in the healthcare dataset.

select count(*) AS total_Nums from diabetic_data;

-- 2. Identify the top 10 most frequent diagnoses in the dataset.

SELECT diag_1 AS diagnosis, count(*) AS frequency FROM diabetic_data
GROUP BY diag_1
ORDER BY frequency DESC
LIMIT 10;

-- 3. Calculate the average length of hospital stay for each admission type.

SELECT admission_type_id, AVG(time_in_hospital) AS avg_length_of_stay FROM diabetic_data
GROUP BY admission_type_id; 

-- 4. Determine the number of readmitted patients and the percentage of total encounters that they represent.

SELECT COUNT(*) AS readmitted_count, ROUND(COUNT(*) * 100.0/
            (SELECT COUNT(*) FROM diabetic_data), 2) AS percentage

FROM diabetic_data
WHERE readmitted != 'NO';

-- 5. Identify the age distribution of patients.

SELECT age, COUNT(*) AS patient_count FROM diabetic_data
GROUP BY age
ORDER BY age;

-- 6. Identify the most common procedures performed during patient encounters.

SELECT num_procedures, COUNT(*) AS frequency FROM diabetic_data
GROUP BY num_procedures
ORDER BY frequency DESC
LIMIT 5;

-- 7. Calculate the average number of medications prescribed for patients in each age group.

SELECT age, AVG(num_medications) AS avg_medications FROM diabetic_data
GROUP BY age
ORDER BY age;

-- 8. Identify the distribution of readmission rates across different payer codes.

SELECT payer_code,

       SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
       COUNT(*) AS total_encounters,

       ROUND(
            (SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) * 100.0)
            / COUNT(*),
       2) AS readmission_rate
FROM diabetic_data
GROUP BY payer_code
ORDER BY readmission_rate DESC;


