/* Below query tells the average contribution for each candidate in each report year. */
SELECT candidates.party,
candidates.candidate_name, 
ROUND(AVG(contributions.contribution_receipt_amount)::numeric, 2) as "Average Contribution", 
COUNT(contributions.contribution_receipt_amount), 
contributions.report_year 
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidates.party, contributions.candidate_id, candidates.candidate_name, contributions.report_year
ORDER BY candidates.party, candidates.candidate_name, contributions.report_year DESC

/* Below query tells the sum of contributions by entity and report year for each candidate */
SELECT candidates.candidate_name, 
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions", 
COUNT(contributions.contribution_receipt_amount),
contributions.report_year,
contributions.entity_type
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY contributions.entity_type, contributions.candidate_id, candidates.candidate_name, contributions.report_year
ORDER BY candidates.candidate_name, contributions.report_year DESC, contributions.entity_type DESC

/* Below query tells the sum of financial party support for each candidate */
SELECT candidates.candidate_name, 
candidates.party,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions", 
COUNT(contributions.contribution_receipt_amount),
contributions.report_year,
contributions.entity_type
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PTY'
GROUP BY contributions.entity_type, candidates.party, contributions.candidate_id, candidates.candidate_name, contributions.report_year
ORDER BY candidates.candidate_name, contributions.report_year DESC

/* Query shows all Party contributions */
SELECT
candidates.candidate_name,
candidates.party,
contributions.contribution_receipt_date as "Date",
contributions.contribution_receipt_amount as "Contribution Amount",
contributions.donor_committee_name
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PTY'
ORDER BY candidates.party


/* Query tells the sum and count PAC support to each candidate in each report year */
SELECT candidates.candidate_name, 
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions", 
COUNT(contributions.contribution_receipt_amount),
contributions.report_year,
contributions.entity_type
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PAC'
GROUP BY contributions.entity_type, contributions.candidate_id, candidates.candidate_name, contributions.report_year
ORDER BY candidates.candidate_name, contributions.report_year

/* Query tells the sum and count PAC support to each candidate REPORT YEARS COMBINED*/
SELECT candidates.candidate_name, 
candidates.party,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions", 
COUNT(contributions.contribution_receipt_amount),
contributions.entity_type
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PAC'
GROUP BY contributions.entity_type, contributions.candidate_id, candidates.candidate_name, candidates.party
ORDER BY candidates.candidate_name, contributions.entity_type DESC

/* Query tells which party recieved more PAC financial support */
SELECT
candidates.party,
contributions.entity_type,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions"
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PAC'
GROUP BY candidates.party, contributions.entity_type
ORDER BY "Sum of Contributions" DESC

/* Query tells which party recieved more Party financial support */
SELECT
candidates.party,
contributions.entity_type,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions"
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PTY'
GROUP BY candidates.party, contributions.entity_type
ORDER BY "Sum of Contributions" DESC

/* Query tells count of and sum of contributions per month */
SELECT
  candidates.candidate_name,
  date_trunc('month', contributions.contribution_receipt_date) as "Month",
  COUNT(*) as "Number of Contributions",
  ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions"
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY
  candidates.candidate_name,
  to_char(contributions.contribution_receipt_date, 'Month')
ORDER BY candidates.candidate_name, date_trunc('month', contributions.contribution_receipt_date) as "Month"


/* Query tells count of and sum of contributions per state received by each candidate */
SELECT
candidates.candidate_name,
candidates.party,
contributions.contributor_state,
COUNT(*),
SUM(contributions.contribution_receipt_amount)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidates.candidate_name, candidates.party, contributions.contributor_state
ORDER BY candidates.party, candidates.candidate_name, contributions.contributor_state


/* Query tells the $ sum contributions that come from their home state */
SELECT
candidates.candidate_name,
candidates.candidate_state,
SUM(contributions.contribution_receipt_amount)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidates.candidate_name, candidates.candidate_state


/* Query tells the percent of ($sum) contributions that come from their home state */

SELECT
candidates.candidate_name,
candidates.race,
candidates.candidate_state,
SUM(contributions.contribution_receipt_amount) / (
    SELECT 
)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE contributions.contributor_state = candidates.candidate_state
GROUP BY
ORDER BY candidates.party, candidates.candidate_name


/* Query tells the top 3 occupations for count & sum of contributions for each candidate */




/* FINAL Queries */


/* Below query tells the sum of financial party support for each candidate */
SELECT candidates.candidate_name, 
candidates.party,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions", 
COUNT(contributions.contribution_receipt_amount),
contributions.report_year,
contributions.entity_type
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PTY'
GROUP BY contributions.entity_type, candidates.party, contributions.candidate_id, candidates.candidate_name, contributions.report_year
ORDER BY candidates.candidate_name, contributions.report_year DESC

/* Query tells which party recieved more PAC financial support */
SELECT
candidates.party,
contributions.entity_type,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as "Sum of Contributions"
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE entity_type = 'PAC'
GROUP BY candidates.party, contributions.entity_type
ORDER BY "Sum of Contributions" DESC

/* Query tells sum of contributions per candidate */
SELECT
candidates.candidate_name,
candidates.candidate_race,
candidates.party,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*),
ROUND(ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) / count(*)::numeric, 2) as average_contribution
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidate_name, candidates.party, candidates.candidate_race
ORDER BY ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) DESC


/* Query tells sum of contributions per state */
SELECT 
candidates.candidate_state,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidates.candidate_state 
ORDER BY ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) DESC


SELECT contributor_occupation,
COUNT(contributor_occupation) as count_hi,
AVG(contribution_receipt_amount) 
FROM Contributions
GROUP BY contributor_occupation
ORDER BY COUNT(contributor_occupation) DESC

SELECT candidate_race
FROM candidates

SELECT 
contributor_state,
COUNT(contributor_state),
SUM(contribution_receipt_amount)
FROM contributions
GROUP BY contributor_state
ORDER BY COUNT(contributor_state) DESC

SELECT contributor_name
FROM contributions
WHERE contributor_state IS NULL

SELECT contributor_name
FROM contributions
WHERE contributor_state = 'AE'

/* Query tells sum of contributions per candidate */
SELECT
candidates.candidate_name,
candidates.candidate_race,
candidates.party,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*),
ROUND(ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) / count(*)::numeric, 2) as average_contribution
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
GROUP BY candidate_name, candidates.party, candidates.candidate_race
ORDER BY ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) DESC

/* Query finds ingredients for percentage in/out of state PA */
SELECT
candidates.candidate_name,
candidates.candidate_state,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE candidate_state = 'PA'
GROUP BY candidate_name, candidates.party, candidates.candidate_state
ORDER BY candidates.candidate_name

SELECT
candidates.candidate_name,
candidates.candidate_state,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE candidate_state = 'PA'
AND Contributions.contributor_state = 'PA'
GROUP BY candidate_name, candidates.party, candidates.candidate_state
ORDER BY candidates.candidate_name


/* Query finds ingredients for percentage in/out of state NJ */
SELECT
candidates.candidate_name,
candidates.candidate_state,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE candidate_state = 'NJ'
GROUP BY candidate_name, candidates.party, candidates.candidate_state
ORDER BY candidates.candidate_name

SELECT
candidates.candidate_name,
candidates.candidate_state,
ROUND(SUM(contributions.contribution_receipt_amount)::numeric, 2) as sum_of_contributions,
count(*)
FROM candidates
JOIN contributions ON contributions.candidate_id=candidates.candidate_id
WHERE candidate_state = 'NJ'
AND Contributions.contributor_state = 'NJ'
GROUP BY candidate_name, candidates.party, candidates.candidate_state
ORDER BY candidates.candidate_name

SELECT * from candidates

SELECT * from contributions WHERE entity_type = 'ORG'