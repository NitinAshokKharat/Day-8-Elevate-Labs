CREATE DATABASE IF NOT EXISTS rsmartshop;
USE rsmartshop;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2)
);

-- Inserting sample data

INSERT INTO Customers VALUES 
(1, 'Nitin', 'Pune'),
(2, 'Priya', 'Mumbai');

INSERT INTO Orders VALUES
(101, 1, 500.00),
(102, 2, 700.00),
(103, 1, 150.00);

DELIMITER $$
CREATE FUNCTION GetTotalAmount(cust_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(amount) INTO total 
    FROM Orders 
    WHERE customer_id = cust_id;

    RETURN IFNULL(total, 0);
END$$

DELIMITER ;

SELECT name, GetTotalAmount(customer_id) AS total_spent
FROM Customers;
