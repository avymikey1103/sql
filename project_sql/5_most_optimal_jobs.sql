WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS job_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = true
    GROUP BY
        skills_dim.skill_id
), 
average_salary AS (
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 3) AS avg_yearly_salary_skill,
        COUNT(skills_job_dim.job_id) AS job_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = true
    GROUP BY
        skills_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    ROUND(0.6 * (average_salary.avg_yearly_salary_skill / MAX(average_salary.avg_yearly_salary_skill) OVER ())
    + 0.4 * (skills_demand.job_count / MAX(skills_demand.job_count) OVER ()), 3) AS score,
    skills_demand.job_count,
    average_salary.avg_yearly_salary_skill
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE skills_demand.job_count > 10
ORDER BY score DESC
LIMIT 25;
