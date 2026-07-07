-- which category performed best on average?
-- grouped by category across all key metrics

SELECT
    category,
    COUNT(*)                     AS total_funds,
    ROUND(AVG(cagr_5y), 2)      AS avg_cagr,
    ROUND(AVG(sharpe_ratio), 2)  AS avg_sharpe,
    ROUND(AVG(volatility), 2)    AS avg_volatility,
    ROUND(AVG(max_drawdown), 2)  AS avg_drawdown
FROM fund_metrics
GROUP BY category
ORDER BY avg_cagr DESC;