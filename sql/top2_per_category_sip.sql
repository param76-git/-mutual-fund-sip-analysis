-- top 2 funds per category ranked by sip returns
-- uses window function RANK() OVER PARTITION

SELECT fund_name, category, sip_returns, current_value, profit
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY category ORDER BY sip_returns DESC) AS rnk
    FROM sip_results
) ranked
WHERE rnk <= 2
ORDER BY category, sip_returns DESC;