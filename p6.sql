
CREATE TABLE jan_2023 AS
    SELECT *
    FROM  
        job_postings_fact 
    WHERE
        EXTRACT (MONTH FROM job_posted_date) = 1;

CREATE TABLE feb_2023 AS
    SELECT *
    FROM  
        job_postings_fact 
    WHERE
        EXTRACT (MONTH FROM job_posted_date) = 2;

CREATE TABLE mar_2023 AS
    SELECT *
    FROM  
        job_postings_fact 
    WHERE
        EXTRACT (MONTH FROM job_posted_date) = 3;

CREATE TABLE q1_2023 AS 
        (
        SELECT *
        FROM
            jan_2023
        UNION
        SELECT *
        FROM
            feb_2023
        UNION
        SELECT *
        FROM
            mar_2023);
SELECT *
FROM q1_2023;

SELECT *
FROM q1_2023_2;

CREATE TABLE q1_2023_2 AS 
        (
        SELECT 
            job_title_short,
            company_id,
            job_location
        FROM
            jan_2023
        UNION ALL
        SELECT 
            job_title_short,
            company_id,
            job_location
        FROM
            feb_2023
        UNION ALL
        SELECT 
            job_title_short,
            company_id,
            job_location
        FROM
            mar_2023
        );