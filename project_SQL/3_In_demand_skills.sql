-- Identify the top 5 in-demand skills for Data Analyst roles in India and Remote positions.

SELECT 
    skills,
    Count(skills_job_dim.job_id) AS job_count
 FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_location='India' OR
    job_location='Remote'
GROUP BY
    skills
ORDER BY
    job_count DESC
LIMIT 5