

WITH skill_count AS (
    SELECT
        skills_job_dim.skill_id as skill,
        COUNT(*) as job_count
    FROM 
        skills_job_dim
    WHERE (skills_job_dim.job_id IN (
        SELECT job_postings_fact.job_id
        FROM job_postings_fact
        WHERE job_location = 'Anywhere' AND 
        job_postings_fact.job_title_short = 'Data Analyst'
    ))
    GROUP BY
        skill
)

SELECT 
    skill_count.skill,
    skills_dim.skills,
    skill_count.job_count
FROM 
    skills_dim
INNER JOIN skill_count
    ON skills_dim.skill_id = skill_count.skill
WHERE 
    skill_count.job_count IS NOT NULL
ORDER BY 
    skill_count.job_count DESC
LIMIT 5;

