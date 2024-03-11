# Analyze Data in a Model Car Database with MySQL Workbench (Coursera Project Network)

## Project Description:
In this project, I'm helping a pretend company called Mint Classics with data analysis. I'm a beginner data analyst, and the company is 
dealing with issues related to inventory and storage facilities. The problem at hand involves the decision to close one of the existing storage facilities

## Demonstrated Skills:
1. Data Analysis: I will use SQL to extract and analyze data from the Mint Classics relational database.
2. Business Understanding: I will grasp the database structure and Mint Classics' business processes to provide relevant solutions.
3. Decision-Making: I will formulate recommendations based on findings from data analysis.

## Project Work Process:
Here's a step-by-step explanation of the process:
### Task 1 - Import the Classic Model Car Relational Database
 
I successfully imported the Classic Model Car Relational Database using MySQL Workbench. Here's a step-by-step explanation of the process:

**Steps:**

   **Step 1: Download the SQL Script**

   I downloaded the mintclassicsDB.sql file from the provided link in the project working platfrom. This file contains the SQL script necessary to create and populate the Mint Classics relational database.

Download file: [mintClassicsDB](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/blob/main/SQL%20file/mintclassicDB.sql)

   **Step 2: Open MySQL Workbench and Connect to Local Server**

  I ensured that MySQL Workbench was installed on my workstation and opened it. I connected to a local server instance to ensure a smooth import process.

  **Step 3: Access the Data Import Tool**

In MySQL Workbench, I clicked on the "Server" option in the menu bar and selected the "Data Import" tool. This tool is crucial for importing data into the database.

  **Step 4: Choose "Import from Self-Contained File"**

Within the Data Import tool, I selected the "Import from Self-Contained File" option. This choice allows me to import the database using the SQL script file I had downloaded.

   **Step 5: Navigate to the SQL Script File**

I then navigated to the location where I had downloaded the mintclassicsDB.sql file. After selecting the file, I clicked the "Start Import" button to initiate the import process.

**Step 6: Monitor the Import Process**

During the import process, I monitored the progress to ensure that it completed without any errors. The Data Import tool provides feedback on the import status.
|Import File|
| ----------- |
|![Screenshot (259)](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/094f635a-544d-48cd-a8e1-343de0998f69) |

### Task 2 – Familiarize yourself with the Mint Classic database and business processes.
After successfully imported the Classic Model Car Relational Database in MySQL Workbench.
Now I have created an EER Diagram. Here's a step-by-step explanation of the process:

**Step 1:** In this, I carefully examined the Extended Entity-Relationship (EER) diagram provided for the Mint Classic database. The EER diagram serves as a visual representation of the database structure, showcasing the relationships and connections between different tables. By analyzing the table names and their connections, I gained insights into how data flows and how various entities are related.

For instance, I observed relationships such as:

  - An employee working with a customer to place an order.
  - An order containing multiple products.
  - Each product belonging to a specific product line.
  - Products being stored in a particular warehouse.

Understanding these relationships helped me visualize how business activities are mirrored in the database structure.
|Model Overview|
| ----------- |
![Screenshot (263)](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/935337af-61fc-40c4-83ec-f4527ca16b18)

**Step 2:** Next, I used the Navigation pane in MySQL Workbench to explore the contents of each table in the Mint Classic database. This step allowed me to gain a deeper understanding of the actual data stored in the tables and the relationships between them. I focused on examining values for common fields/columns that relate tables. For example, I looked at the warehouseCode field present in both the "warehouses" table and the "products" table. By reviewing the values in this common field, I could establish connections between warehouses and products, providing insights into the storage locations of different products.

|Extended Entity-Relationship (EER) diagram|
| ----------- |
|![Screenshot 2024-03-11 132237](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/8526b027-8370-4371-b739-d3b46fbfeae9)|

### Task 3 – Investigate the business problem and identify tables impacted.

  **Identifying Fields and Tables Related to the Business Problem:**

  - Identify fields related to the inventory and storage facilities.
    
         DESCRIBE mintclassics.products;
         DESCRIBE mintclassics.warehouses;
    
Similar queries for other relevant tables

|Products|Warehouses|
| ----------- |----|
 |![Screenshot (286)](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/a20fb2e1-189c-4733-9448-7d97fde4adc6)|![Screenshot (287)](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/e347822f-ede5-4b0d-ad67-5714bb6bc603)|

  - Understand the structure and content of tables containing relevant data.
     
         -- Sample query to inspect the first few rows of the products table
         SELECT * FROM mintclassics.products LIMIT 5;
    
    ![Screenshot (288)](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/assets/118357991/8081b409-8487-40d7-a29c-22ce5583460c)

Similar queries for other relevant tables

### Task 4 – Formulate suggestions and recommendations for solving the business problem.
        
  **Data Analysis:**
  
The following question will be analyzed in this project:

1. Which products have too much in stock compared to what customers are buying? How can we make sure we don't have too many of these products and match what customers want?
2. Which products are stored in each warehouse, and how can we find out if some warehouses have too much or too little stock?
3. How do different product prices impact the total quantity ordered, and can we identify products where adjustments in pricingcould potentially boost overall sales?
4. How can we identify and nurture customer segments that contribute the most to sales, and what strategies can be implemented to focus sales efforts on these valuable customer groups?
5. How can individual sales employees' performance metrics be analyzed, and what strategies can be implemented to recognize and enhance the contributions of top-performing sales team members?
6. How can historical customer payment trends be examined to identify potential credit risks, and what proactive measures can be implemented to manage cash flow effectively?
7. Which specific products within each product line contribute the most to the overall success of that product line, and how can this information guide decisions on product improvement or removal?
8. How can the historical credit utilization patterns of customers be analyzed to assess the effectiveness of existing credit policies, and what adjustments could be considered to enhance credit risk management?

Explore the all this above question - [View](https://github.com/yogeshkasar778/Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench/blob/main/SQL%20file/Analyze%20Data%20in%20a%20Model%20Car%20Database-MintClassics.sql)
























