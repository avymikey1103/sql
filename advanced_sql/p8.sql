SELECT 
    job_title_short,
    job_title,
    job_location,
    job_via,
    job_posted_date::date,
    salary_year_avg
FROM
    (SELECT *
    FROM jan_2023 
    UNION ALL
    SELECT *
    FROM feb_2023 
    UNION ALL
    SELECT *
    FROM mar_2023) AS quarter1_2023
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;