-- 1. 
SELECT product_id, count(id) AS "number_of_transaction"
FROM transaction
GROUP BY product_id
ORDER BY "number_of_transaction" DESC;

--2.
SELECT COUNT(a.agent_id)
FROM agent a
JOIN transaction t on a.agent_id = t.agent_id
WHERE a.join_date == t.registration_date;

--3
-- SELECT DISTINCT ON (t.id) te.status, te.created_at, t.id
-- FROM facts_transaction t 
-- JOIN dim_transaction_event te on te.transaction_id = t.id
-- ORDER BY t.id, te.created_at DESC;

SELECT DISTINCT ON (t.id) te.status, te.created_at, t.id
FROM transaction t
JOIN transaction_event te on te.transaction_id = t.id
ORDER BY t.id, te.created_at DESC;

--4
-- SELECT dt.registration_month, COUNT(t.agent_id)
-- FROM facts_transaction t
-- JOIN dim_transaction dt on t.id = dt.transaction_id
-- GROUP BY dt.registration_month
-- ORDER BY registration_month ASC;


-- SELECT EXTRACT(MONTH FROM join_date) as "join_month", COUNT(agent_id)
-- FROM dim_agents
-- WHERE join_date IS NOT NULL
-- GROUP BY "join_month"
-- ORDER BY "join_month" ASC;


-- WITH months AS (
--     SELECT generate_series(1, 12) AS mon
-- ),
-- sales AS (
--     SELECT registration_month, COUNT(*) AS cnt
--     FROM facts_transaction f
--     JOIN dim_transaction d ON f.id = d.transaction_id
--     GROUP BY registration_month
-- )
-- SELECT 
--     m.mon,
--     COALESCE(s.cnt, 0) AS transaction_count
-- FROM months m
-- LEFT JOIN sales s ON m.mon = s.registration_month
-- ORDER BY m.mon;


WITH months AS (
-- cte for month column
    SELECT generate_series(1, 12) AS mon
),
transactions AS (
-- cte for transaction column
    SELECT registration_month, COUNT(*) AS tx_count
    FROM facts_transaction f
    JOIN dim_transaction d ON f.id = d.transaction_id
    GROUP BY registration_month
),
agents_joined AS (
-- cte for agents_joined, extract month join_date and count the number of 
-- agent per month
    SELECT EXTRACT(MONTH FROM join_date)::int AS mon, COUNT(*) AS agents
    FROM dim_agents
    WHERE join_date IS NOT NULL
    GROUP BY EXTRACT(MONTH FROM join_date)
)
SELECT 
-- select month
-- transacton, 0 if there's no month
-- agent_joined, 0 if there's no mo
    m.mon AS month,
    COALESCE(t.tx_count, 0) AS transactions,
    COALESCE(a.agents, 0) AS agents_joined,
    ROUND(
        COALESCE(t.tx_count, 0)::numeric / NULLIF(a.agents, 0), 2
    ) AS transactions_per_agent
FROM months m
LEFT JOIN transactions t ON m.mon = t.registration_month
LEFT JOIN agents_joined a ON m.mon = a.mon
ORDER BY m.mon;

-- 5
-- 6
-- 7 
-- The sample data is quite dirty. Based on the data pipeline that I made
-- The sample has duplicate data in the transaction
-- Transaction worksheet has multiple agent id not present in agent worksheet
-- missing value is payment status 
-- impossible date 
