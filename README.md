### 📊 **Dashboard: Trading House Analytics**

#### **Overview**
This dashboard was created at the request of the Trading House Director to provide a comprehensive view of business performance. It includes all key metrics necessary for monitoring and decision-making, such as GMV, OTIF, order fulfillment, product categories, and delivery performance.

This dashboard is highly specialized in the 1877 catalog, which is defined as a trading house catalog.

---

### 📌 **Main Sections**

---

#### **1. GMV Dynamics**
- **Widget Type**: Line Chart
- **Description**: Shows the dynamics of Gross Merchandise Value (GMV) from October 2024 to July 2025.
- **Purpose**: To track trends in sales volume and identify seasonal patterns or growth/decline points.

---

#### **2. OTIF (On-Time In Full) Performance**

##### **2.1 OTIF by GMV**
- **Widget Type**: Bar Chart
- **Description**: Displays the GMV of orders delivered on time (purple) and delayed (orange), grouped by month.
- **Metric**: Planned delivery date
- **Purpose**: To assess the percentage of orders delivered on time and identify delivery bottlenecks.

##### **2.2 OTIF by Order Count**
- **Widget Type**: Bar Chart
- **Description**: Shows the number of orders delivered on time (purple) and delayed (orange), grouped by month.
- **Purpose**: Complements the GMV-based OTIF metric with order-level analysis.

---

#### **3. Delivery Performance**
- **Widget Type**: Bar Chart
- **Description**: Shows the number of orders by delivery type: full delivery, partial delivery, and no delivery.
- **Purpose**: To analyze the completeness of order fulfillment and identify issues in the logistics chain.

---

#### **4. Product Categories**
- **Widget Type**: Pie Chart / Horizontal Bar Chart
- **Description**: Displays the share of GMV by product category.
- **Purpose**: To understand which categories contribute the most to overall sales.

---

#### **5. Top 10 Products by GMV**
- **Widget Type**: Table / Horizontal Bar Chart
- **Description**: Lists the top 10 products by GMV.
- **Purpose**: Helps identify best-selling items and potential growth opportunities.

---

#### **6. Delayed Orders**
- **Widget Type**: Table / Bar Chart
- **Description**: Shows the number of delayed orders grouped by responsible party: Supplier, Logistics, or Warehouse.
- **Purpose**: Aids in root cause analysis and accountability tracking.

---

#### **7. SQL_code**
| File | Widget | Description |
|------|--------|-------------|
| `1.1_GMV_and_related.sql` | GMV Dynamics, Orders, Orders under 1500, Average Check, Ownership Time | Calculates key sales metrics |
| `2.1_OTIF_analysis.sql` | OTIF by GMV and Model Count | Shows on-time and delayed orders |
| `3.1_Cancel_reasons.sql` | Cancel Reasons | Lists reasons for supplier order cancellations |

---

### 🛠️ **Data Sources**
- SQL queries executed in Postgres
- Final dataset prepared using SQL and visualized via Metabase

---

### 📌 **Use Cases**
- Monitoring trading house performance
- Identifying bottlenecks in delivery
- Supporting strategic decisions by the Trading House Director

---

## 🖥️ Sample Output


<img width="1827" height="898" alt="image" src="https://github.com/user-attachments/assets/7497bfd1-a88c-45e0-b886-8351cd627872" />

