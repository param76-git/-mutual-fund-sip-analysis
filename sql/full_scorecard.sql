-- joining metrics and sip results to get complete fund picture
-- this is a JOIN across two tables on fund_name

SELECT TOP 10
    m.fund_name,
    m.category,
    m.cagr_5y,
    m.sharpe_ratio,
    s.sip_returns,
    s.current_value,
    s.profit
FROM fund_metrics m
JOIN sip_results s ON m.fund_name = s.fund_name
ORDER BY m.sharpe_ratio DESC;