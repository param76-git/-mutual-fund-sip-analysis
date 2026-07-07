-- which active funds individually beat the best index fund?
-- best index fund cagr = 22.43% (motilal oswal nifty midcap 150)

SELECT
    fund_name,
    category,
    cagr_5y,
    sharpe_ratio
FROM fund_metrics
WHERE category != 'Index Fund'
  AND cagr_5y > (
        SELECT MAX(cagr_5y)
        FROM fund_metrics
        WHERE category = 'Index Fund'
      )
ORDER BY cagr_5y DESC;
