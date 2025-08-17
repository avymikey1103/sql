SELECT *
FROM (
    SELECT *
    FROM job_postings_fact 
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
    );

WITH january_jobs AS ( 
    SELECT *
    FROM job_postings_fact 
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;


SELECT DISTINCT
    companies.name,
    companies.company_id,
    job_no_degree_mention
FROM 
    job_postings_fact
LEFT JOIN company_dim AS companies
    ON job_postings_fact.company_id = companies.company_id
WHERE
    job_no_degree_mention = true;

SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention = true
);

SELECT
    name,
    COUNT(job_title) AS job_count
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
GROUP BY
    name
ORDER BY
    job_count DESC;
    

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    )

SELECT 
    name,
    company_job_count.job_count
FROM
    company_dim
LEFT JOIN company_job_count 
    ON company_job_count.company_id = company_dim.company_id
ORDER BY
    job_count DESC;


