SELECT 
    EXTRACT (MONTH FROM job_posted_date) AS date_time_month,
    COUNT(job_id) as job_count  
FROM  
    job_postings_fact 
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    date_time_month
ORDER BY
    job_count DESC