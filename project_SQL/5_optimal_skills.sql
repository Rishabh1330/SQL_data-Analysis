--- Identify the top 10 optimal skills for Data Analyst roles in India and Remote positions based on demand and average salary.
WITH skills_demand as (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        Count(skills_job_dim.job_id) AS job_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND 
        job_location='India' OR
        job_location='Remote'
    GROUP BY
        skills_dim.skill_id
),avg_salary as (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg)) as avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND 
        job_location='India' OR
        job_location='Remote'
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    job_count,
    avg_salary
FROM skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY
    avg_salary DESC,
    job_count DESC
LIMIT 10