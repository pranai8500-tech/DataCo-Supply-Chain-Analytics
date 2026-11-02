# DataCo Supply Chain Analytics

**An end-to-end supply chain analytics project using Python, SQL Server, and an interactive HTML dashboard to evaluate operational performance, identify delivery risks, analyze shipping efficiency, and generate data-driven business recommendations.**

<p align="center">
  <a href="https://pranai8500-tech.github.io/DataCo-Supply-Chain-Analytics/">
    <img src="https://img.shields.io/badge/Live_Dashboard-Explore_Analytics-2563EB?style=for-the-badge" alt="Live Dashboard" />
  </a>
  <a href="https://github.com/pranai8500-tech/DataCo-Supply-Chain-Analytics">
    <img src="https://img.shields.io/badge/GitHub-Source_Code-181717?style=for-the-badge&logo=github" alt="GitHub Repository" />
  </a>
  <img src="https://img.shields.io/badge/Domain-Supply_Chain_Analytics-0F766E?style=for-the-badge" alt="Supply Chain Analytics" />
</p>

---

## 1. Executive Summary

Supply chain operations involve multiple interconnected activities, including order processing, inventory management, shipping, delivery execution, and customer fulfillment.

I developed this project to analyze supply chain performance using the DataCo dataset, identify delivery-related risks, evaluate shipping performance, and understand operational patterns that can affect customer satisfaction and business efficiency.

The project follows an end-to-end analytics workflow covering data quality assessment, Python preprocessing, SQL Server analysis, interactive dashboard development, and business reporting.

**Key business question:** Where are supply chain operations experiencing delivery risks, and which shipping and operational segments should management prioritize for improvement?

**Project deliverables:**

- Cleaned and validated supply chain dataset
- Python data cleaning and exploratory analysis notebook
- SQL Server KPI calculations and business queries
- Interactive HTML analytics dashboard
- Business analysis report
- Data-driven operational recommendations

**Project status:** Completed portfolio analysis based on the available DataCo dataset.

### Project Links

- **Live Dashboard:** [Explore the DataCo Supply Chain Dashboard](https://pranai8500-tech.github.io/DataCo-Supply-Chain-Analytics/)
- **GitHub Repository:** [View Source Code](https://github.com/pranai8500-tech/DataCo-Supply-Chain-Analytics)

---

## 2. Business Problem

Supply chain businesses need to monitor delivery performance, shipping efficiency, order volumes, and operational risks to maintain reliable fulfillment.

Delivery delays can affect customer satisfaction, increase operational costs, and create inefficiencies across logistics operations.

This project investigates the following business questions:

1. How many orders and order items are represented in the dataset?
2. What is the overall late-delivery risk?
3. How do delivery outcomes vary across shipping modes?
4. Which shipping modes show the highest delivery risk?
5. How many orders were delivered late, on time, or ahead of schedule?
6. How do sales and order volumes vary across product and customer segments?
7. Which operational areas should be investigated to improve delivery performance?
8. What actions could help reduce delivery delays and improve supply chain efficiency?

**Business objective:** Transform raw supply chain data into measurable operational KPIs, meaningful performance insights, and actionable recommendations.

---

## 3. Dataset Overview

The project uses the DataCo Supply Chain dataset.

The analyzed dataset contains:

- **180,519 records**
- **50 columns** in the cleaned analytical dataset
- Order, customer, product, shipping, delivery, and sales-related information

### Key Data Categories

| Category | Example fields | Analytical purpose |
|---|---|---|
| Order information | Order ID, Order Item ID, Order Date | Analyze order volumes and processing patterns |
| Customer information | Customer ID, Customer Segment, Customer Country | Evaluate customer and market segments |
| Product information | Product ID, Product Category, Product Price | Analyze product-level performance |
| Sales information | Sales, Benefit per Order, Order Item Quantity | Evaluate sales and order economics |
| Shipping information | Shipping Mode, Days for Shipping | Compare shipping methods |
| Delivery information | Delivery Status, Late Delivery Risk, Days for Shipment | Evaluate fulfillment and delivery performance |
| Geographic information | City, State, Country, Market | Explore geographic performance |

**Data preparation note:** The original dataset was reviewed and cleaned before downstream analysis. Missing values, data types, duplicate records, invalid dates, and key-field consistency were examined.

---

## 4. Tools & Technologies

| Tool | Application |
|---|---|
| Python | Data cleaning, validation, and exploratory analysis |
| Pandas & NumPy | Data manipulation and preprocessing |
| Jupyter Notebook | Reproducible Python analysis |
| SQL Server | KPI calculations, aggregations, and business queries |
| SQL Server Management Studio | Database management and query execution |
| Claude AI | Assistance with interactive HTML dashboard development |
| HTML, CSS & JavaScript | Dashboard structure, styling, and interactions |
| Chart.js | Interactive data visualizations |
| Microsoft Excel | Dataset inspection and review |
| PDF | Business analysis reporting |
| Git & GitHub | Version control and project documentation |
| GitHub Pages | Dashboard hosting |

---

## 5. Analytical Workflow

### Step 1: Data Loading & Exploration

- Loaded the original dataset into Python using Pandas.
- Examined dataset dimensions, column names, and data types.
- Reviewed missing values and duplicate records.
- Identified important order, customer, product, sales, and delivery fields.
- Investigated data inconsistencies and potential quality issues.

### Step 2: Data Cleaning & Validation

- Reviewed missing and invalid values.
- Checked primary-key uniqueness and duplicate records.
- Validated date fields and shipping-related dates.
- Examined numerical fields and corrected data types.
- Checked relationships between order, customer, and product information.
- Prepared the cleaned dataset for SQL Server analysis.

### Step 3: SQL Server Business Analysis

- Imported the cleaned dataset into SQL Server.
- Developed SQL queries to calculate supply chain KPIs.
- Analyzed order volumes, shipping modes, and delivery outcomes.
- Evaluated late-delivery risk across shipping categories.
- Compared delivery performance between different operational segments.
- Prepared business-focused query results for reporting and visualization.

### Step 4: Interactive Dashboard Development

- Developed an interactive HTML dashboard with assistance from Claude AI.
- Presented key operational KPIs and supply chain performance indicators.
- Used interactive visualizations to communicate delivery and shipping patterns.
- Used HTML, CSS, JavaScript, and Chart.js for dashboard development.

### Step 5: Business Reporting

- Consolidated analytical findings into a business report.
- Interpreted delivery and shipping performance.
- Identified operational areas that require further investigation.
- Developed recommendations for improving fulfillment performance.

---

## 6. Key Performance Indicators

The following figures are reported from the project analysis.

| KPI | Reported result |
|---|---:|
| Total Order Items | 180,519 |
| Unique Purchase Orders | 65,752 |
| Total Units Ordered | 376,204 |
| Late Delivery Risk Records | 98,977 |
| Late Delivery Risk Rate | 57.29% |
| Late Deliveries | 103,400 |
| On-Time Deliveries | 33,753 |
| Early Deliveries | 43,366 |

### KPI Interpretation

- **Order items:** The dataset contains 180,519 order-item records.
- **Purchase orders:** The analysis identifies 65,752 unique purchase orders.
- **Order quantity:** A total of 376,204 units were ordered according to the reported quantity calculation.
- **Late-delivery risk:** 98,977 records are classified as having late-delivery risk, representing approximately 57.29% of the dataset.
- **Delivery outcomes:** The reported delivery-status counts distinguish late, on-time, and early delivery outcomes.

**Important metric distinction:** Late Delivery Risk and actual delivery status are different measures. The late-delivery risk indicator should not be treated as equivalent to the number of orders actually delivered late.

---

## 7. Key Findings & Operational Insights

### Finding 1: Overall Late-Delivery Risk

The analysis identifies 98,977 records with late-delivery risk, representing 57.29% of the dataset.

**Business implication:** Delivery risk is an important operational area to investigate. Management should examine the factors associated with high-risk orders and review fulfillment processes.

### Finding 2: Shipping Mode Performance

The reported shipping-mode analysis shows differences in late-delivery risk.

| Shipping Mode | Records | Reported Late-Delivery Risk Rate |
|---|---:|---:|
| First Class | 26,513 | 100.00% |
| Second Class | 33,806 | 79.83% |
| Same Day | 9,293 | 47.93% |
| Standard Class | 103,153 | 39.77% |

**Business implication:** First Class and Second Class show higher reported late-delivery risk than Same Day and Standard Class. These patterns deserve further investigation into scheduling, fulfillment capacity, shipment handling, and risk classification.

### Finding 3: Actual Delivery Outcomes

The reported delivery-status distribution is:

| Delivery Outcome | Records |
|---|---:|
| Late | 103,400 |
| On Time | 33,753 |
| Early | 43,366 |

**Business implication:** Delivery outcomes should be monitored separately from predicted or classified delivery risk. This distinction helps management evaluate both operational performance and risk identification.

### Finding 4: Order and Fulfillment Scale

The dataset contains 65,752 unique purchase orders and 180,519 order-item records.

**Business implication:** Operational monitoring should account for the difference between purchase orders and individual order items. These measures represent different levels of the supply chain.

**Interpretation note:** These findings describe patterns in the analyzed dataset. They do not establish that shipping mode alone causes delivery delays.

---

## 8. Business Recommendations

| Priority | Recommendation | Business rationale | Suggested measurement |
|---|---|---|---|
| High | Investigate First Class delivery performance | Highest reported late-delivery risk rate | Late-risk rate and actual late-delivery rate |
| High | Review Second Class fulfillment operations | Elevated reported delivery risk | Delivery performance by shipping mode |
| High | Monitor delivery outcomes separately from risk | Risk classification and actual delivery status are different measures | Risk accuracy and delivery-status distribution |
| Medium | Improve shipment scheduling and capacity planning | Investigate potential operational bottlenecks | Average shipping days and delay rate |
| Medium | Establish regular delivery performance monitoring | Track changes in operational performance | Weekly or monthly delivery KPIs |
| Medium | Investigate geographic delivery patterns | Identify locations requiring additional operational attention | Late-delivery rate by region |
| Medium | Review product and order characteristics | Identify order profiles associated with delays | Delivery outcomes by product and order segment |

### Recommended Next Steps

1. Validate delivery-risk and delivery-status definitions.
2. Investigate why First Class and Second Class have elevated risk rates.
3. Examine geographic and product-level delivery patterns.
4. Compare shipping time and actual delivery performance.
5. Introduce regular KPI monitoring.
6. Measure the impact of operational improvements over time.

---

## 9. Interactive Dashboard

[**Launch the Live DataCo Supply Chain Dashboard →**](https://pranai8500-tech.github.io/DataCo-Supply-Chain-Analytics/)

The dashboard provides an interactive view of supply chain performance, including operational KPIs, delivery indicators, and shipping-mode analysis.

Use the dashboard to explore the reported findings and investigate different dimensions of supply chain performance.

**Dashboard repository:** [DataCo-Supply-Chain-Analytics](https://github.com/pranai8500-tech/DataCo-Supply-Chain-Analytics)

---

## 10. Repository Structure

The following is a logical representation of the project components. Actual filenames and folder names may differ; update this section to match the repository.

```text
DataCo-Supply-Chain-Analytics/
│
├── Dataset/
│   ├── DataCoSupplyChainDataset2.csv
│   └── cleaned_supply_chain.csv
│
├── Python/
│   └── Supply_Chain_Analysis.ipynb
│
├── SQL/
│   └── Supply_Chain_Analysis.sql
│
├── Dashboard/
│   └── index.html
│
├── Reports/
│   └── DataCo_Supply_Chain_Analytics_Report.pdf
│
└── README.md
```

---

## 11. How to Run the Project

### A. Python Analysis

1. Clone the repository:

```bash
git clone https://github.com/pranai8500-tech/DataCo-Supply-Chain-Analytics.git
cd DataCo-Supply-Chain-Analytics
```

2. Install Python and Jupyter Notebook.
3. Install the required packages:

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

4. Open the project notebook in Jupyter Notebook.
5. Update dataset paths if necessary.
6. Run the notebook cells to reproduce the cleaning and exploratory analysis.

### B. SQL Server Analysis

1. Open SQL Server Management Studio (SSMS).
2. Create or select the required database.
3. Import the cleaned dataset into SQL Server.
4. Update the database and table references in the SQL script if necessary.
5. Execute the queries to reproduce the KPIs and business analysis.

### C. Interactive HTML Dashboard

Open the [live dashboard](https://pranai8500-tech.github.io/DataCo-Supply-Chain-Analytics/) or open the dashboard's `index.html` file locally if included in the repository.

An internet connection may be required for externally hosted JavaScript libraries.

### D. Business Report

Open the PDF report in the repository, if included, to review the detailed methodology, findings, recommendations, and limitations.

---

## 12. Limitations & Future Improvements

### Current Limitations

- The analysis is based on the available dataset rather than a live operational data feed.
- Late-delivery risk and actual delivery status are separate measures and should not be combined.
- Shipping-mode differences are observational and do not establish causation.
- Additional operational variables may be required to explain delivery delays.
- Some dataset fields require careful interpretation before being used as financial or operational KPIs.
- The analysis does not independently validate the impact of proposed operational improvements.

### Future Improvements

- Develop a delivery-delay prediction model.
- Add geographic delivery performance analysis.
- Analyze warehouse and fulfillment-center performance where data is available.
- Develop customer-level delivery experience metrics.
- Automate data quality validation and KPI reconciliation.
- Add time-based delivery trend and seasonal analysis.
- Integrate live or regularly refreshed supply chain data.

---

## 13. Conclusion

This project demonstrates an end-to-end supply chain analytics workflow using Python, SQL Server, and an interactive HTML dashboard.

Through data cleaning, exploratory analysis, SQL-based KPI development, and business interpretation, the project evaluates order volumes, shipping performance, and delivery-related risks.

The analysis highlights the importance of monitoring delivery risk, distinguishing risk indicators from actual delivery outcomes, and investigating shipping modes with elevated risk.

The key business takeaway is that supply chain performance should be evaluated through clearly defined operational KPIs and targeted investigation of high-risk segments.

The project demonstrates practical skills in data preprocessing, Python, SQL Server, KPI development, operational analysis, dashboard development, and business communication.

---

## Author

**Pranai**  
Data Analytics Portfolio Project

- **GitHub Profile:** [pranai8500-tech](https://github.com/pranai8500-tech)
- **Project Repository:** [DataCo-Supply-Chain-Analytics](https://github.com/pranai8500-tech/DataCo-Supply-Chain-Analytics)
- **Live Dashboard:** [Explore the DataCo Dashboard](https://pranai8500-tech.github.io/DataCo-Supply-Chain-Analytics/)

**Skills demonstrated:** Python, Pandas, NumPy, data cleaning, exploratory data analysis, SQL Server, KPI development, supply chain analytics, delivery performance analysis, shipping-mode analysis, data visualization, interactive dashboard development, and business reporting.
