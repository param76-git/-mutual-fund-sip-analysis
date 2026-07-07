# Mutual Fund & SIP Analysis — India

I built this project to figure out one thing — if you invest ₹5,000 every month in an Indian mutual fund, which type of fund actually gives you the best results?

To answer this, I pulled real historical data for 33 mutual funds from AMFI India, calculated how each fund performed over the last 5 years, and simulated what would have happened if someone had done a monthly SIP across all of them.

---

## What I built

- Fetched real daily NAV data for 33 funds going back to 2013 — that's 96,325 rows of data
- Calculated 5 metrics for every fund: CAGR, Sharpe Ratio, Volatility, Max Drawdown, and 1-year return
- Simulated a ₹5,000/month SIP from January 2020 to January 2025 for every fund
- Loaded all the results into SQL Server and wrote queries to find patterns
- Built 6 charts showing fund comparisons, SIP growth, and active vs passive performance

---

## Tools used

- **Python** — for everything
- **Pandas** — cleaning and analysing the data
- **mftool** — to fetch live NAV data from AMFI India
- **Matplotlib** — for all the charts
- **SQL Server** — to query the fund metrics like a database
- **Jupyter Notebook** — where all the code lives

---

## Files in this project

```
mutualfund_project/
│
├── notebooks/
│   ├── 01_data_collection.ipynb   ← fetch and clean data, analyse one fund in detail
│   ├── 02_sip_comparison.ipynb    ← run SIP simulation for all 33 funds
│   ├── 03_insights.ipynb          ← charts, rankings, active vs passive comparison
│   └── 04_sql_analysis.ipynb      ← SQL queries on the fund data
│
├── data/
│   ├── all_funds_nav.csv          ← 96,325 rows of raw NAV data
│   ├── fund_comparison.csv        ← all 33 funds with their metrics
│   ├── sip_comparison.csv         ← SIP results for every fund
│   └── final_rankings.csv         ← combined ranking table
│
└── output/
    ├── nav_comparison_chart.png
    ├── sip_comparison_charts.png
    ├── sip_growth_over_time.png
    ├── active_vs_passive.png
    ├── rolling_returns.png
    └── final_dashboard.png
```

---

## The 33 funds — how I picked them

I started with 50 funds but ran into a real-world data problem — many popular fund codes in mftool either returned wrong data or no data at all. Rather than keep bad data in the analysis, I removed those funds and worked with the 33 that were fully verified.

| Category | Funds |
|---|---|
| Large Cap | 6 funds — Mirae Asset, HDFC Flexi Cap, Parag Parikh, and 3 more |
| Mid Cap | 10 funds — HDFC Mid-Cap, Quant Mid Cap, Motilal Oswal, and 7 more |
| Small Cap | 9 funds — Quant Small Cap, SBI Small Cap, Nippon India, and 6 more |
| Index Fund | 8 funds — UTI Nifty 50, SBI Nifty, ICICI Pru Nifty 50, and 5 more |

---

## What the metrics mean

**CAGR** — how much the fund grew per year on average. Like an interest rate, but for mutual funds.

**Volatility** — how much the fund jumps up and down day to day. Low volatility means a smoother ride.

**Sharpe Ratio** — this is the most important one. It tells you how much return you got for the risk you took. A fund that gives 20% return by taking huge risks is worse than one that gives 18% return calmly. Anything above 1.0 is excellent.

**Max Drawdown** — the worst fall the fund took from its peak. For example, -38% means the fund fell 38% from its highest point before recovering.

**SIP Simulation** — I invested ₹5,000 on the first trading day of every month, bought units at that day's actual NAV, and checked the final value in January 2025.

---

## What I found

### Small Cap funds came out on top

| Category | Avg yearly return | Avg Sharpe |
|---|---|---|
| Small Cap | 24.78% | 0.98 |
| Mid Cap | 20.56% | 0.80 |
| Large Cap | ~16% | ~0.61 |
| Index Fund | 14.88% | 0.52 |

Small Cap funds gave nearly 10% more annual return than Index Funds — and also had the best Sharpe Ratio. They were not just higher return, they were also better return-per-risk.

---

### Active funds beat index funds in India

People often say "just buy an index fund, active managers can't beat the market." That might be true in the US. In India, over this 5-year period:

- Active funds averaged **21.12% yearly return**
- Index funds averaged **14.88% yearly return**
- 10 out of 25 active funds beat even the best index fund

Mid Cap and Small Cap fund managers genuinely added value here.

---

### Best fund in each category

| Category | Winner | 5Y Return | Sharpe |
|---|---|---|---|
| Small Cap | Quant Small Cap Fund | 35.54% | 1.29 |
| Mid Cap | Edelweiss Mid Cap Fund | 25.47% | 0.98 |
| Large Cap | Parag Parikh Flexi Cap Fund | 20.39% | 0.98 |
| Index Fund | Motilal Oswal Nifty Midcap 150 | 22.43% | 0.85 |

---

### SIP results — ₹5,000 every month for 5 years

Total invested in each fund: **₹3,05,000**

| Category | Average returns | Best fund | Best fund returns |
|---|---|---|---|
| Small Cap | 119% | Quant Small Cap | 174.97% |
| Mid Cap | 88.72% | Edelweiss Mid Cap | 100.2% |
| Large Cap | 67.51% | Parag Parikh Flexi Cap Fund | 71.7% |
| Index Fund | 72.24% | Motilal Oswal Nifty Midcap 150 |83.7%  |

The best result: ₹3,05,000 put into Quant Small Cap through monthly SIP became **₹8,38,659**.
That is a profit of ₹5,33,659 — almost 3x the original investment — through a simple ₹5,000 monthly SIP.

Every single fund gave positive returns. This 5-year window included the COVID crash of March 2020, which makes this more impressive.

---

### COVID crash — what happened

The worst week in the dataset was 19–26 March 2020. HDFC Mid-Cap fell just **2.38%** from its peak during that entire crash week. Someone who started a ₹5,000/month SIP in January 2020 — right before COVID hit — still walked away with **28.7% total returns** by January 2025. The SIP kept buying units cheaply during the crash, which is exactly how SIP is supposed to work.

---

### Best risk-reward funds

These two funds gave above-average returns but fell less than their peers during market downturns:

| Fund | Return | Max Fall | Sharpe |
|---|---|---|---|
| Parag Parikh Flexi Cap Fund | 20.39% | -31.20% | 0.98 |
| Quant Mid Cap Fund | 25.70% | -33.43% | 0.96 |

---

## SQL queries I wrote

After the Python analysis, I loaded everything into SQL Server and ran 5 queries:

```sql
-- Which category performed best?
SELECT category, AVG(cagr_5y), AVG(sharpe_ratio)
FROM fund_metrics
GROUP BY category
ORDER BY avg_sharpe DESC

-- Which active funds beat the best index fund?
SELECT fund_name, cagr_5y FROM fund_metrics
WHERE category != 'Index Fund' AND cagr_5y > 22.43

-- Top 2 funds per category by SIP returns
SELECT fund_name, category, sip_returns
FROM (
    SELECT *, RANK() OVER (PARTITION BY category ORDER BY sip_returns DESC) AS rnk
    FROM sip_results
) t WHERE rnk <= 2

-- High return + low drawdown funds (sweet spot)
SELECT fund_name, cagr_5y, max_drawdown FROM fund_metrics
WHERE cagr_5y > (SELECT AVG(cagr_5y) FROM fund_metrics)
  AND max_drawdown > (SELECT AVG(max_drawdown) FROM fund_metrics)

-- Full scorecard joining metrics and SIP results
SELECT TOP 10 m.fund_name, m.cagr_5y, m.sharpe_ratio, s.sip_returns
FROM fund_metrics m
JOIN sip_results s ON m.fund_name = s.fund_name
ORDER BY m.sharpe_ratio DESC
```

---

## How to run this

```bash
# Clone the repo
git clone https://github.com/yourusername/mutual-fund-sip-analysis
cd mutual-fund-sip-analysis

# Set up virtual environment (Windows)
python -m venv venv
venv\Scripts\activate.bat

# Install libraries
pip install pandas mftool matplotlib seaborn pyodbc sqlalchemy openpyxl jupyter

# Run notebooks in order
# 01 → 02 → 03 → 04
```

Notebook 4 needs SQL Server installed. Update the server name in Cell 1 to match your machine. Database name is `mutualfund_analysis`.

---

## What I learnt building this

Fixing data problems took longer than the actual analysis. Several fund codes returned wrong data from AMFI — for example, one "equity fund" code returned NAV values of ₹1,100+ that barely moved over 6 years, which is impossible for an equity fund. Catching these errors before they corrupted the results was the most important part of the project.

The Sharpe Ratio was more useful than raw returns for comparing funds fairly. A fund giving 20% return by taking huge risks is not better than one giving 18% with half the volatility — and Sharpe captures that difference.

---

## About

**Paramjeet Kumawat** | Aspiring Data and Business Analyst
(Python · SQL · Pandas · Matplotlib · Power BI)

---

*Data from AMFI India via mftool. Built for learning and portfolio purposes — not financial advice.*
