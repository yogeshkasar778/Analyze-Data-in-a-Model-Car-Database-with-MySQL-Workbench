-- Analyze Data in a Model Car Database with MySQL Workbench*/
-- Ovwerview
/*In this project, I'm helping a pretend company called Mint Classics with data analysis. I'm a beginner data analyst, and the company is 
dealing with issues related to inventory and storage facilities. The problem at hand involves the decision to close one of the existing storage facilities*/

/*1. Which products have too much in stock compared to what customers are buying? How can we make sure we don't have too many of 
these products and match what customers want?*/

WITH TotalQuantityOrder AS
(SELECT p.productCode, p.productName, p.quantityInStock, SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM
    mintclassics.products as p
JOIN
    mintclassics.orderdetails as od ON p.productCode = od.productCode
GROUP BY
    p.productCode, p.productName, p.quantityInStock)
SELECT productCode, productName, quantityInStock, totalQuantityOrdered,
       (quantityInStock - totalQuantityOrdered) AS inventoryShortage, 
       ((quantityInStock - totalQuantityOrdered) / quantityInStock) * 100 AS shortagePercentage
FROM TotalQuantityOrder
HAVING inventoryShortage > 0
ORDER BY inventoryShortage DESC;

/*2.Which products are stored in each warehouse, and how can we find out if some warehouses have too much or too little stock?*/

SELECT p.productCode, p.productName, w.warehouseCode, w.warehouseName,
       SUM(p.quantityInStock) AS totalQuantityInStock
FROM
    mintclassics.products AS p
JOIN
    mintclassics.warehouses AS w ON p.warehouseCode = w.warehouseCode
GROUP BY p.productCode, p.productName, w.warehouseCode, w.warehouseName
ORDER BY totalQuantityInStock DESC;

/*3.How do different product prices impact the total quantity ordered, and can we identify products where adjustments in pricing
 could potentially boost overall sales?*/
 
SELECT p.productCode, p.productName, p.buyPrice,
       COUNT(od.productCode) AS Total_Orders,
       SUM(od.quantityOrdered) AS Total_Quantity_Ordered,
       AVG(od.quantityOrdered) AS averageQuantityOrdered
FROM
    mintclassics.products AS p
JOIN
    mintclassics.orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.buyPrice
ORDER BY p.buyPrice DESC;

/*4.How can we identify and nurture customer segments that contribute the most to sales, and what strategies can be implemented to focus 
sales efforts on these valuable customer groups?*/

WITH CustomerSales AS (
    SELECT c.customerNumber, c.customerName, SUM(od.quantityOrdered * od.priceEach) AS Total_Sales
    FROM
        mintclassics.customers AS c
    JOIN
        mintclassics.orders AS o ON c.customerNumber = o.customerNumber
    JOIN
        mintclassics.orderdetails AS od ON o.orderNumber = od.orderNumber
    GROUP BYc.customerNumber, c.customerName
)
SELECT customerNumber, customerName,Total_Sales, RANK() OVER (ORDER BY Total_Sales DESC) AS sales_Rank
FROM
    CustomerSales
ORDER BY
    Total_Sales DESC;

/*5.How can individual sales employees' performance metrics be analyzed, and what strategies can be implemented to recognize and 
enhance the contributions of top-performing sales team members?*/

WITH EmployeePerformance AS (
    SELECT e.employeeNumber, e.lastName, e.firstName, e.jobTitle,
           SUM(od.quantityOrdered * od.priceEach) AS Total_Sales
    FROM
        mintclassics.employees AS e
    LEFT JOIN
        mintclassics.customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
    LEFT JOIN
        mintclassics.orders AS o ON c.customerNumber = o.customerNumber
    LEFT JOIN
        mintclassics.orderdetails AS od ON o.orderNumber = od.orderNumber
    GROUP BY e.employeeNumber, e.lastName, e.firstName, e.jobTitle)
SELECT employeeNumber, lastName, firstName, jobTitle, Total_Sales,
       RANK() OVER (ORDER BY Total_Sales DESC) AS sales_Rank
FROM
    EmployeePerformance;

/*6.How can historical customer payment trends be examined to identify potential credit risks, and what proactive measures can be 
implemented to manage cash flow effectively?*/

WITH CustomerPaymentTrends AS (
    SELECT  c.customerNumber, c.customerName, p.paymentDate,p.amount,c.creditLimit,
            (c.creditLimit - SUM(p.amount)) AS Credit_Remaining
    FROM
        mintclassics.customers AS c
    LEFT JOIN
        mintclassics.payments AS p ON c.customerNumber = p.customerNumber
    GROUP BY c.customerNumber, c.customerName, p.paymentDate, p.amount,c.creditLimit
)

SELECT c.customerNumber, c.customerName, cpt.paymentDate, c.creditLimit, cpt.amount, cpt.Credit_Remaining,
    CASE
        WHEN cpt.Credit_Remaining < 0 THEN 'Credit Risk'
        ELSE 'No Credit Risk'
    END AS Credit_Risk_Status
FROM
    mintclassics.customers AS c
LEFT JOIN
    CustomerPaymentTrends AS cpt ON c.customerNumber = cpt.customerNumber
ORDER BY c.customerNumber, cpt.paymentDate;

/*7.Which specific products within each product line contribute the most to the overall success of that product line, and how can this 
information guide decisions on product improvement or removal?*/

WITH ProductLineContribution AS (
    SELECT p.productCode, p.productName, pl.productLine,
          SUM(od.quantityOrdered) AS Total_Quantity_Ordered
    FROM
        mintclassics.products AS p
    JOIN
        mintclassics.productlines AS pl ON p.productLine = pl.productLine
    JOIN
        mintclassics.orderdetails AS od ON p.productCode = od.productCode
    GROUP BY p.productCode, p.productName, pl.productLine
),
RankedProducts AS (
    SELECT productCode, productName, productLine, Total_Quantity_Ordered,
           RANK() OVER (PARTITION BY productLine ORDER BY Total_Quantity_Ordered DESC) AS product_Rank
    FROM
        ProductLineContribution
)
SELECT productCode, productName, productLine, Total_Quantity_Ordered
FROM
    RankedProducts
WHERE
    product_Rank = 1;

/*8.How can the historical credit utilization patterns of customers be analyzed to assess the effectiveness of existing credit policies, 
and what adjustments could be considered to enhance credit risk management?*/

WITH CreditUtilization AS (
    SELECT c.customerNumber, c.customerName, c.creditLimit, SUM(p.amount) AS Total_Payments,
           (c.creditLimit - SUM(p.amount)) AS Credit_Utilization
    FROM
        mintclassics.customers AS c
    LEFT JOIN
        mintclassics.payments AS p ON c.customerNumber = p.customerNumber
    GROUP BY
        c.customerNumber, c.customerName, c.creditLimit
)

SELECT customerNumber, customerName, creditLimit, Total_Payments,
       Credit_Utilization
FROM
    CreditUtilization;

-------------------------------------------------Thank You! ------------------------------------------------------------------------------
