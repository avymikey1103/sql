SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 3) AS avg_yearly_salary_skill,
    COUNT(skills_job_dim.job_id) AS job_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL 
GROUP BY
    skills_dim.skills
HAVING 
    ROUND(AVG(job_postings_fact.salary_year_avg), 3) > 70000 AND
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_yearly_salary_skill DESC
LIMIT 500;