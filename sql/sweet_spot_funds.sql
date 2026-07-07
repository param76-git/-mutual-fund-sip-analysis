-- funds with above average return AND above average drawdown protection
-- these are the funds worth recommending to a cautious investor

SELECT
    fund_name,
    category,
    cagr_5y,
    max_drawdown,
    sharpe_ratio
FROM fund_metrics
WHERE cagr_5y     > (SELECT AVG(cagr_5y)      FROM fund_metrics)
  AND max_drawdown > (SELECT AVG(max_drawdown) FROM fund_metrics)
ORDER BY sharpe_ratio DESC;\