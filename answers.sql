
-- Question 1 Achieving 1NF (First Normal Form)
-- SQL query that transform the table into 1NF, ensuring that each row represents a single product for an order
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

INSERT INTO ProductDetail VALUES 
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

SELECT 
    pd.OrderID, 
    pd.CustomerName, 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail pd
JOIN 
    (SELECT 1 AS n UNION ALL 
     SELECT 2 UNION ALL 
     SELECT 3 UNION ALL 
     SELECT 4 UNION ALL 
     SELECT 5 UNION ALL 
     SELECT 6) AS numbers
ON 
    numbers.n <= 1 + LENGTH(pd.Products) - LENGTH(REPLACE(pd.Products, ',', ''))
ORDER BY 
    pd.OrderID, Product;

-- Question 2 Achieving 2NF (Second Normal Form) 
-- SQL query that transform the table from 1NF into 2NF by removing partial dependencies. 
-- Ensure that each non-key column fully depends on the entire primary key.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),  
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

