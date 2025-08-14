# AgriTrade SQL & PL/SQL Project

This project is a practice Oracle SQL + PL/SQL database for an agricultural trading system.  
It contains scripts for table creation, sample data insertion, SQL queries, and PL/SQL blocks (triggers, procedures, functions, exception handling, cursors, etc.).

---

## 📂 Project Structure

- **tables.sql** → Table creation scripts  
- **insert_data.sql** → Sample data for testing  
- **queries.sql** → SQL practice queries (joins, subqueries, views, indexes) with questions & answers  
- **plsql_objects.sql** → PL/SQL scripts for triggers, functions, and procedures with questions & answers  
- **plsql_advanced.sql** → Advanced PL/SQL (exception handling, cursors, bulk collect, forall) with questions & answers  
- **ER_Diagram.png** → Database ER diagram (optional)  

---

## 📊 Tables

1. **Farmer** – Who produces crops  
2. **Crop** – Types of agricultural products  
3. **Farmer_Crop** – Which farmer grows which crop (with quantity and price)  
4. **Buyer** – Who purchases crops  
5. **Order_Master** – Main order info (buyer, date, status)  
6. **Order_Details** – Crops & quantities per order  
7. **Shipment** – Delivery details for an order  
8. **Payment** *(optional)* – Order payment records  

---

## 🚀 How to Use

1. **Create Database Structure**
   ```sql
   @tables.sql
@insert_data.sql
@queries.sql
@plsql_objects.sql
@plsql_advanced.sql
