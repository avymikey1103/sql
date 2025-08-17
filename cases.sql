SELECT 
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_type,
    COUNT(job_title_short)
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    location_type;