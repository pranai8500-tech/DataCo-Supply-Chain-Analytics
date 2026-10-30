select *
from DataCoSupplyChain_Cleaned

-- Step 1: View column names, data types, and sizes

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCoSupplyChain_Cleaned'
ORDER BY ORDINAL_POSITION;



--Total Customer Orders
SELECT
    COUNT(DISTINCT [Order Id]) AS Total_Customer_Orders
FROM dbo.DataCoSupplyChain_Cleaned;


--Total Units Sold
SELECT
    SUM([Order Item Quantity]) AS Total_Units_Sold
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED';

--Total Sales Revenue
SELECT
    ROUND(SUM([Sales]), 2) AS Total_Sales_Revenue
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED';


--On-Time Delivery Rate
SELECT
    COUNT(CASE
        WHEN [Delivery Status] IN (
            'Advance shipping',
            'Shipping on time'
        ) THEN 1
    END) AS On_Time_Order_Lines,

    COUNT(CASE
        WHEN [Delivery Status] IN (
            'Advance shipping',
            'Shipping on time',
            'Late delivery'
        ) THEN 1
    END) AS Total_Delivered_Order_Lines,

    CAST(
        100.0 * COUNT(CASE
            WHEN [Delivery Status] IN (
                'Advance shipping',
                'Shipping on time'
            ) THEN 1
        END)
        / NULLIF(COUNT(CASE
            WHEN [Delivery Status] IN (
                'Advance shipping',
                'Shipping on time',
                'Late delivery'
            ) THEN 1
        END), 0)
        AS DECIMAL(6,2)
    ) AS On_Time_Delivery_Rate_Percent
FROM dbo.DataCoSupplyChain_Cleaned;


--Average Shipping Delay
SELECT
    AVG(CAST([Shipping Delay Days] AS DECIMAL(10,2)))
        AS Average_Delay_Days
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Shipping Delay Days] > 0;


--Verify the late delivery rate
SELECT
    COUNT(CASE
        WHEN [Delivery Status] = 'Late delivery'
        THEN 1
    END) AS Late_Order_Lines,

    CAST(
        100.0 * COUNT(CASE
            WHEN [Delivery Status] = 'Late delivery'
            THEN 1
        END)
        / NULLIF(COUNT(CASE
            WHEN [Delivery Status] IN (
                'Advance shipping',
                'Shipping on time',
                'Late delivery'
            ) THEN 1
        END), 0)
        AS DECIMAL(6,2)
    ) AS Late_Delivery_Rate_Percent
FROM dbo.DataCoSupplyChain_Cleaned;


--Delivery performance by shipping mode
SELECT
    [Shipping Mode],
    COUNT(*) AS Total_Order_Lines,
    SUM(CASE
        WHEN [Delivery Status] = 'Late delivery'
        THEN 1 ELSE 0
    END) AS Late_Order_Lines,
    CAST(
        100.0 * SUM(CASE
            WHEN [Delivery Status] = 'Late delivery'
            THEN 1 ELSE 0
        END)
        / NULLIF(COUNT(CASE
            WHEN [Delivery Status] IN (
                'Advance shipping',
                'Shipping on time',
                'Late delivery'
            ) THEN 1
        END), 0)
        AS DECIMAL(6,2)
    ) AS Late_Delivery_Rate_Percent
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Delivery Status] IN (
    'Advance shipping',
    'Shipping on time',
    'Late delivery'
)
GROUP BY [Shipping Mode]
ORDER BY Late_Delivery_Rate_Percent DESC;



--Check whether delivery labels match shipping delays
SELECT
    [Shipping Mode],
    [Delivery Status],
    COUNT(*) AS Total_Order_Lines,

    SUM(CASE
        WHEN [Shipping Delay Days] > 0 THEN 1
        ELSE 0
    END) AS Actually_Delayed_Lines,

    SUM(CASE
        WHEN [Shipping Delay Days] <= 0 THEN 1
        ELSE 0
    END) AS On_Schedule_Or_Early_Lines

FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Delivery Status] IN (
    'Advance shipping',
    'Shipping on time',
    'Late delivery'
)
GROUP BY
    [Shipping Mode],
    [Delivery Status]
ORDER BY
    [Shipping Mode],
    [Delivery Status];


--Average shipping delay by shipping mode
SELECT
    [Shipping Mode],
    COUNT(*) AS Total_Order_Lines,

    SUM(CASE
        WHEN [Shipping Delay Days] > 0 THEN 1
        ELSE 0
    END) AS Delayed_Order_Lines,

    CAST(
        AVG(
            CASE
                WHEN [Shipping Delay Days] > 0
                THEN CAST([Shipping Delay Days] AS DECIMAL(10,2))
            END
        ) AS DECIMAL(10,2)
    ) AS Avg_Delay_Among_Late_Lines,

    MAX([Shipping Delay Days]) AS Maximum_Delay_Days

FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Delivery Status] IN (
    'Advance shipping',
    'Shipping on time',
    'Late delivery'
)
GROUP BY [Shipping Mode]
ORDER BY Avg_Delay_Among_Late_Lines DESC;


--Delivery performance by region
SELECT
    [Order Region],
    COUNT(*) AS Total_Order_Lines,

    SUM(CASE
        WHEN [Delivery Status] = 'Late delivery'
        THEN 1 ELSE 0
    END) AS Late_Order_Lines,

    CAST(
        100.0 * SUM(CASE
            WHEN [Delivery Status] = 'Late delivery'
            THEN 1 ELSE 0
        END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Late_Delivery_Rate_Percent,

    CAST(
        AVG(CASE
            WHEN [Shipping Delay Days] > 0
            THEN CAST([Shipping Delay Days] AS DECIMAL(10,2))
        END)
        AS DECIMAL(10,2)
    ) AS Avg_Delay_Among_Late_Lines

FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Delivery Status] IN (
    'Advance shipping',
    'Shipping on time',
    'Late delivery'
)
GROUP BY [Order Region]
ORDER BY Late_Delivery_Rate_Percent DESC;


--Sales by product category
SELECT
    [Category Name],
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    COUNT(DISTINCT [Order Id]) AS Total_Customer_Orders,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales_Revenue,
    CAST(AVG([Sales]) AS DECIMAL(18,2)) AS Avg_Sales_Per_Order_Line
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Category Name]
ORDER BY Total_Sales_Revenue DESC;


--Product profitability
SELECT
    [Product Name],
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales,
    CAST(
        SUM([Order Profit Per Order]) AS DECIMAL(18,2)
    ) AS Total_Profit,
    CAST(
        100.0 * SUM([Order Profit Per Order])
        / NULLIF(SUM([Sales]), 0)
        AS DECIMAL(8,2)
    ) AS Profit_Margin_Percent
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Product Name]
ORDER BY Total_Profit DESC;


--order-level profit repeated across multiple items
SELECT TOP 20
    [Order Id],
    COUNT(*) AS Order_Lines,
    MIN([Order Profit Per Order]) AS Min_Order_Profit,
    MAX([Order Profit Per Order]) AS Max_Order_Profit,
    SUM([Sales]) AS Total_Line_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Order Id]
ORDER BY Order_Lines DESC;



--Monthly sales trend
SELECT
    YEAR([order date (DateOrders)]) AS Sales_Year,
    MONTH([order date (DateOrders)]) AS Sales_Month,
    COUNT(DISTINCT [Order Id]) AS Total_Customer_Orders,
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY
    YEAR([order date (DateOrders)]),
    MONTH([order date (DateOrders)])
ORDER BY
    Sales_Year,
    Sales_Month;


--Monthly Sales Trend — Results and Business Insights
SELECT
    YEAR([order date (DateOrders)]) AS Sales_Year,
    MONTH([order date (DateOrders)]) AS Sales_Month,
    [Order Status],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [order date (DateOrders)] >= '2017-09-01'
GROUP BY
    YEAR([order date (DateOrders)]),
    MONTH([order date (DateOrders)]),
    [Order Status]
ORDER BY
    Sales_Year,
    Sales_Month,
    [Order Status];


--Calculate month-over-month sales growth
WITH MonthlySales AS (
    SELECT
        DATEFROMPARTS(
            YEAR([order date (DateOrders)]),
            MONTH([order date (DateOrders)]),
            1
        ) AS Sales_Month,
        SUM([Sales]) AS Total_Sales
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY
        YEAR([order date (DateOrders)]),
        MONTH([order date (DateOrders)])
),
SalesGrowth AS (
    SELECT
        Sales_Month,
        Total_Sales,
        LAG(Total_Sales) OVER (
            ORDER BY Sales_Month
        ) AS Previous_Month_Sales
    FROM MonthlySales
)
SELECT
    Sales_Month,
    CAST(Total_Sales AS DECIMAL(18,2)) AS Total_Sales,
    CAST(Previous_Month_Sales AS DECIMAL(18,2))
        AS Previous_Month_Sales,
    CAST(
        100.0 * (Total_Sales - Previous_Month_Sales)
        / NULLIF(Previous_Month_Sales, 0)
        AS DECIMAL(8,2)
    ) AS Month_Over_Month_Growth_Percent
FROM SalesGrowth
ORDER BY Sales_Month;


--Average Order Value (AOV)
WITH OrderSales AS (
    SELECT
        [Order Id],
        SUM([Sales]) AS Order_Revenue
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY [Order Id]
)
SELECT
    COUNT(*) AS Total_Orders,
    CAST(AVG(Order_Revenue) AS DECIMAL(18,2))
        AS Average_Order_Value
FROM OrderSales;


--Order Cancellation Rate
WITH OrderStatus AS (
    SELECT
        [Order Id],
        MAX(CASE
            WHEN [Order Status] = 'CANCELED' THEN 1
            ELSE 0
        END) AS Is_Canceled
    FROM dbo.DataCoSupplyChain_Cleaned
    GROUP BY [Order Id]
)
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Is_Canceled) AS Canceled_Orders,
    CAST(
        100.0 * SUM(Is_Canceled) / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Cancellation_Rate_Percent
FROM OrderStatus;

--Sales by Market
SELECT
    [Market],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Market]
ORDER BY Total_Sales DESC;



--Sales by Customer Segment
SELECT
    [Customer Segment],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    COUNT(DISTINCT [Order Customer Id]) AS Unique_Customers,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales,
    CAST(AVG([Sales]) AS DECIMAL(18,2)) AS Avg_Order_Line_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Customer Segment]
ORDER BY Total_Sales DESC;


--Sales by Shipping Mode
SELECT
    [Shipping Mode],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales,
    CAST(
        100.0 * SUM([Sales]) /
        NULLIF(SUM(SUM([Sales])) OVER (), 0)
        AS DECIMAL(6,2)
    ) AS Sales_Share_Percent
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Shipping Mode]
ORDER BY Total_Sales DESC;


--Average Discount Rate by Category
SELECT
    [Category Name],
    CAST(AVG([Order Item Discount Rate]) * 100
        AS DECIMAL(6,2)) AS Avg_Discount_Rate_Percent,
    CAST(SUM([Order Item Discount])
        AS DECIMAL(18,2)) AS Total_Discount_Amount,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Category Name]
ORDER BY Avg_Discount_Rate_Percent DESC;


--Average Customer Revenue
WITH CustomerSales AS (
    SELECT
        [Order Customer Id],
        SUM([Sales]) AS Customer_Revenue
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY [Order Customer Id]
)
SELECT
    COUNT(*) AS Purchasing_Customers,
    CAST(AVG(Customer_Revenue) AS DECIMAL(18,2))
        AS Average_Revenue_Per_Customer,
    CAST(MAX(Customer_Revenue) AS DECIMAL(18,2))
        AS Highest_Customer_Revenue
FROM CustomerSales;


--Repeat Purchase Rate
WITH CustomerOrders AS (
    SELECT
        [Order Customer Id],
        COUNT(DISTINCT [Order Id]) AS Order_Count
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY [Order Customer Id]
)
SELECT
    COUNT(*) AS Purchasing_Customers,
    SUM(CASE WHEN Order_Count > 1 THEN 1 ELSE 0 END)
        AS Repeat_Customers,
    CAST(
        100.0 * SUM(CASE WHEN Order_Count > 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Repeat_Purchase_Rate_Percent
FROM CustomerOrders


--How many unique customers placed non-canceled orders
SELECT
    COUNT(DISTINCT [Order Customer Id]) AS Unique_Customers
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED';


--Which customer segments generate the most orders
SELECT
    [Customer Segment],
    COUNT(DISTINCT [Order Customer Id]) AS Unique_Customers,
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Customer Segment]
ORDER BY Total_Orders DESC;


--Which 10 customers generate the highest revenue
SELECT TOP 10
    [Order Customer Id] AS Customer_ID,
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Revenue
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Order Customer Id]
ORDER BY Total_Revenue DESC;


--What is the repeat purchase rate
WITH CustomerOrders AS (
    SELECT
        [Order Customer Id],
        COUNT(DISTINCT [Order Id]) AS Order_Count
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY [Order Customer Id]
)
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Order_Count > 1 THEN 1 ELSE 0 END)
        AS Repeat_Customers,
    CAST(
        100.0 * SUM(CASE WHEN Order_Count > 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Repeat_Purchase_Rate_Percent
FROM CustomerOrders;


--What is the average order value (AOV)
WITH OrderSales AS (
    SELECT
        [Order Id],
        SUM([Sales]) AS Order_Revenue
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
    GROUP BY [Order Id]
)
SELECT
    COUNT(*) AS Total_Orders,
    CAST(AVG(Order_Revenue) AS DECIMAL(18,2))
        AS Average_Order_Value
FROM OrderSales;


--What percentage of orders were canceled
WITH OrderStatus AS (
    SELECT
        [Order Id],
        MAX(CASE
            WHEN [Order Status] = 'CANCELED' THEN 1
            ELSE 0
        END) AS Is_Canceled
    FROM dbo.DataCoSupplyChain_Cleaned
    GROUP BY [Order Id]
)
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Is_Canceled) AS Canceled_Orders,
    CAST(
        100.0 * SUM(Is_Canceled) / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Cancellation_Rate_Percent
FROM OrderStatus;


--Which markets generate the highest sales
SELECT
    [Market],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    COUNT(DISTINCT [Order Customer Id]) AS Unique_Customers,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Market]
ORDER BY Total_Sales DESC;


--Which order statuses account for the most orders
WITH OrderStatuses AS (
    SELECT
        [Order Id],
        CASE
            WHEN COUNT(DISTINCT [Order Status]) > 1
                THEN 'Mixed statuses'
            ELSE MAX([Order Status])
        END AS Order_Status_Group
    FROM dbo.DataCoSupplyChain_Cleaned
    GROUP BY [Order Id]
)
SELECT
    Order_Status_Group,
    COUNT(*) AS Total_Orders,
    CAST(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER ()
        AS DECIMAL(6,2)
    ) AS Order_Share_Percent
FROM OrderStatuses
GROUP BY Order_Status_Group
ORDER BY Total_Orders DESC;


--Which products sell the most units
SELECT TOP 10
    [Product Name],
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Product Name]
ORDER BY Total_Units_Sold DESC;


--Which categories sell the most units
SELECT
    [Category Name],
    SUM([Order Item Quantity]) AS Total_Units_Sold,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Category Name]
ORDER BY Total_Units_Sold DESC;


--Which categories receive the highest average discounts
SELECT
    [Category Name],
    CAST(
        AVG([Order Item Discount Rate]) * 100
        AS DECIMAL(6,2)
    ) AS Avg_Discount_Rate_Percent,
    CAST(
        SUM([Order Item Discount])
        AS DECIMAL(18,2)
    ) AS Total_Discount_Amount,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Category Name]
ORDER BY Avg_Discount_Rate_Percent DESC;



--Which products have negative recorded profitability
SELECT TOP 20
    [Order Id],
    COUNT(*) AS Order_Lines,
    MIN([Order Profit Per Order]) AS Min_Order_Profit,
    MAX([Order Profit Per Order]) AS Max_Order_Profit,
    SUM([Sales]) AS Total_Line_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Order Id]
ORDER BY Order_Lines DESC;


--Which shipping modes contribute the most revenue
SELECT
    [Shipping Mode],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales,
    CAST(
        100.0 * SUM([Sales])
        / NULLIF(SUM(SUM([Sales])) OVER (), 0)
        AS DECIMAL(6,2)
    ) AS Sales_Share_Percent
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [Order Status] <> 'CANCELED'
GROUP BY [Shipping Mode]
ORDER BY Total_Sales DESC;

--How do discount levels relate to sales revenue
WITH DiscountAnalysis AS (
    SELECT
        CASE
            WHEN [Order Item Discount Rate] < 0.05
                THEN '0%–5%'
            WHEN [Order Item Discount Rate] < 0.10
                THEN '5%–10%'
            WHEN [Order Item Discount Rate] < 0.15
                THEN '10%–15%'
            WHEN [Order Item Discount Rate] < 0.20
                THEN '15%–20%'
            ELSE '20% and above'
        END AS Discount_Band,
        [Order Id],
        [Order Item Quantity],
        [Sales]
    FROM dbo.DataCoSupplyChain_Cleaned
    WHERE [Order Status] <> 'CANCELED'
)
SELECT
    Discount_Band,
    COUNT(*) AS Order_Lines,
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales,
    CAST(AVG([Sales]) AS DECIMAL(18,2)) AS Avg_Line_Sales
FROM DiscountAnalysis
GROUP BY Discount_Band
ORDER BY Discount_Band;


--Why did sales decline sharply at the end of 2017
SELECT
    YEAR([order date (DateOrders)]) AS Sales_Year,
    MONTH([order date (DateOrders)]) AS Sales_Month,
    [Order Status],
    COUNT(DISTINCT [Order Id]) AS Total_Orders,
    SUM([Order Item Quantity]) AS Total_Units,
    CAST(SUM([Sales]) AS DECIMAL(18,2)) AS Total_Sales
FROM dbo.DataCoSupplyChain_Cleaned
WHERE [order date (DateOrders)] >= '2017-09-01'
GROUP BY
    YEAR([order date (DateOrders)]),
    MONTH([order date (DateOrders)]),
    [Order Status]
ORDER BY
    Sales_Year,
    Sales_Month,
    [Order Status];