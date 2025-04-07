CREATE DATABASE DeliverySystem;
USE DeliverySystem;

CREATE TABLE USERS (
  UserID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL,
  Phone VARCHAR(20),
  Address TEXT,
  UserType ENUM('Customer', 'RestaurantOwner', 'Driver') NOT NULL
);

CREATE TABLE VEHICLE_TYPES (
  VehicleTypeID INT AUTO_INCREMENT PRIMARY KEY,
  Type VARCHAR(20) NOT NULL
);

CREATE TABLE DRIVERS (
  DriverID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT NOT NULL UNIQUE,
  VehicleTypeID INT,
  LicenseNumber VARCHAR(50) NOT NULL,
  AvailabilityStatus ENUM('Available', 'Busy') NOT NULL DEFAULT 'Available',
  FOREIGN KEY (UserID) REFERENCES USERS(UserID),
  FOREIGN KEY (VehicleTypeID) REFERENCES VEHICLE_TYPES(VehicleTypeID)
);

CREATE TABLE CUISINE_CATEGORIES (
  CuisineID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE RESTAURANTS (
  RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Address TEXT NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  OwnerID INT NOT NULL,
  CuisineID INT NOT NULL,
  FOREIGN KEY (OwnerID) REFERENCES USERS(UserID),
  FOREIGN KEY (CuisineID) REFERENCES CUISINE_CATEGORIES(CuisineID)
);

CREATE TABLE ORDERS (
  OrderID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  RestaurantID INT NOT NULL,
  OrderAmount DECIMAL(10,2) NOT NULL,
  OrderTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
  FOREIGN KEY (CustomerID) REFERENCES USERS(UserID),
  FOREIGN KEY (RestaurantID) REFERENCES RESTAURANTS(RestaurantID)
);

CREATE TABLE PACKAGES (
  PackageID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT UNIQUE NOT NULL,
  Weight DECIMAL(5,2) NOT NULL,
  Dimensions VARCHAR(50) NOT NULL,
  PackagingStatus ENUM('Ready', 'Picked', 'Delivered') NOT NULL DEFAULT 'Ready',
  PickupTime DATETIME,
  FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

CREATE TABLE DELIVERY_REQUESTS (
  RequestID INT AUTO_INCREMENT PRIMARY KEY,
  PackageID INT UNIQUE NOT NULL,
  PickupTime DATETIME NOT NULL,
  DeliveryTime DATETIME,
  Status ENUM('Pending', 'Assigned', 'Completed') NOT NULL DEFAULT 'Pending',
  Fee DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (PackageID) REFERENCES PACKAGES(PackageID)
);

CREATE TABLE DELIVERY_DRIVERS (
  RequestID INT NOT NULL,
  DriverID INT NOT NULL,
  PRIMARY KEY (RequestID, DriverID),
  FOREIGN KEY (RequestID) REFERENCES DELIVERY_REQUESTS(RequestID),
  FOREIGN KEY (DriverID) REFERENCES DRIVERS(DriverID)
);

CREATE TABLE TRANSACTIONS (
  TransactionID INT AUTO_INCREMENT PRIMARY KEY,
  RequestID INT UNIQUE NOT NULL,
  Amount DECIMAL(10,2) NOT NULL,
  PaymentMethod ENUM('Card', 'UPI', 'Cash') NOT NULL,
  PaymentStatus ENUM('Pending', 'Successful', 'Failed') NOT NULL DEFAULT 'Pending',
  TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (RequestID) REFERENCES DELIVERY_REQUESTS(RequestID)
);

INSERT INTO VEHICLE_TYPES (Type) VALUES 
('Motorcycle'), ('Bicycle'), ('Car'), ('Scooter'), ('Truck'), ('Van'), ('Auto'), ('Cycle'), ('Rickshaw'), ('Buggy');

INSERT INTO CUISINE_CATEGORIES (CategoryName) VALUES 
('Indian'), ('Chinese'), ('Italian'), ('Mexican'), ('Japanese'), ('Thai'), ('Korean'), ('Greek'), ('Spanish'), ('French');

INSERT INTO USERS (Name, Email, Phone, Address, UserType) 
VALUES 
('Rohan Sharma', 'rohan@example.com', '1234567890', '123 Main St, Delhi', 'Customer'),
('Ravi Kumar', 'ravi@foodie.com', '9876543211', '789 Drive St, Mumbai', 'RestaurantOwner'),
('Aman Yadav', 'aman@driver.com', '9998887777', '88 Lane, Bangalore', 'Driver'),
('Sachin Tendulkar', 'sachin@example.com', '1112223333', '456 Cricket St, Chennai', 'Customer'),
('Priyanka Chopra', 'priyanka@example.com', '4445556666', '789 Bollywood St, Kolkata', 'Customer'),
('Amitabh Bachchan', 'amitabh@example.com', '7778889999', '123 Film St, Hyderabad', 'Customer'),
('Virat Kohli', 'virat@example.com', '3334445555', '456 Sports St, Ahmedabad', 'Customer'),
('Deepika Padukone', 'deepika@example.com', '6667778888', '789 Fashion St, Pune', 'Customer'),
('Salman Khan', 'salman@example.com', '8889990000', '123 Film St, Jaipur', 'Customer'),
('Shah Rukh Khan', 'shahrukh@example.com', '9990001111', '456 Film St, Lucknow', 'Customer'),
('Rahul Gandhi', 'rahul@example.com', '1112223333', '123 Politics St, Delhi', 'Driver'),
('Narendra Modi', 'narendra@example.com', '4445556666', '789 Politics St, Mumbai', 'Driver'),
('Arvind Kejriwal', 'arvind@example.com', '7778889999', '123 Politics St, Bangalore', 'Driver'),
('Mamata Banerjee', 'mamata@example.com', '3334445555', '456 Politics St, Chennai', 'Driver'),
('Rahul Dravid', 'rahuldravid@example.com', '6667778888', '789 Sports St, Kolkata', 'Driver'),
('Sourav Ganguly', 'souravganguly@example.com', '8889990000', '123 Sports St, Hyderabad', 'Driver'),
('MS Dhoni', 'msdhoni@example.com', '9990001111', '456 Sports St, Ahmedabad', 'Driver'),
('Yuvraj Singh', 'yuvrajsingh@example.com', '1112223333', '789 Sports St, Pune', 'Driver'),
('Harbhajan Singh', 'harbhajansingh@example.com', '4445556666', '123 Sports St, Jaipur', 'Driver');

INSERT INTO DRIVERS (UserID, VehicleTypeID, LicenseNumber, AvailabilityStatus) 
VALUES 
(3, 1, 'DL123456', 'Available'),
(11, 2, 'DL789012', 'Available'),
(12, 3, 'DL345678', 'Available'),
(13, 4, 'DL901234', 'Available'),
(14, 5, 'DL567890', 'Available'),
(15, 6, 'DL123456', 'Available'),
(16, 7, 'DL789012', 'Available'),
(17, 8, 'DL345678', 'Available'),
(18, 9, 'DL901234', 'Available'),
(19, 10, 'DL567890', 'Available');

INSERT INTO RESTAURANTS (Name, Address, Phone, OwnerID, CuisineID) 
VALUES 
('Tandoori Nights', '456 Food Ave, Delhi', '9876543210', 2, 1),
('Bollywood Bites', '789 Drive St, Mumbai', '1112223333', 2, 2),
('Spice Route', '123 Main St, Bangalore', '4445556666', 2, 3),
('Mumbai Masala', '456 Cricket St, Chennai', '7778889999', 2, 1),
('Kolkata Kitchen', '789 Bollywood St, Kolkata', '3334445555', 2, 4),
('Hyderabad House', '123 Film St, Hyderabad', '6667778888', 2, 5),
('Ahmedabad Bazaar', '456 Sports St, Ahmedabad', '8889990000', 2, 6),
('Pune Palace', '789 Fashion St, Pune', '9990001111', 2, 7),
('Jaipur Junction', '123 Film St, Jaipur', '1112223333', 2, 8),
('Lucknow Lounge', '456 Film St, Lucknow', '4445556666', 2, 9);

INSERT INTO ORDERS (CustomerID, RestaurantID, OrderAmount, OrderTime, Status) 
VALUES 
(1, 1, 15.99, '2023-10-01 12:30:00', 'Completed'),
(4, 2, 20.99, '2023-10-02 13:00:00', 'Completed'),
(5, 3, 25.99, '2023-10-03 14:00:00', 'Completed'),
(6, 4, 30.99, '2023-10-04 15:00:00', 'Completed'),
(7, 5, 35.99, '2023-10-05 16:00:00', 'Completed'),
(8, 6, 40.99, '2023-10-06 17:00:00', 'Completed'),
(9, 7, 45.99, '2023-10-07 18:00:00', 'Completed'),
(10, 8, 50.99, '2023-10-08 19:00:00', 'Completed'),
(1, 9, 55.99, '2023-10-09 20:00:00', 'Completed'),
(4, 10, 60.99, '2023-10-10 21:00:00', 'Completed');

INSERT INTO PACKAGES (OrderID, Weight, Dimensions, PackagingStatus, PickupTime) 
VALUES 
(1, 2.5, '20x20x30 cm', 'Delivered', '2023-10-01 12:45:00'),
(2, 3.5, '25x25x35 cm', 'Delivered', '2023-10-02 13:15:00'),
(3, 4.5, '30x30x40 cm', 'Delivered', '2023-10-03 14:30:00'),
(4, 5.5, '35x35x45 cm', 'Delivered', '2023-10-04 15:45:00'),
(5, 6.5, '40x40x50 cm', 'Delivered', '2023-10-05 16:55:00'),
(6, 7.5, '45x45x55 cm', 'Delivered', '2023-10-06 18:05:00'),
(7, 8.5, '50x50x60 cm', 'Delivered', '2023-10-07 19:15:00'),
(8, 9.5, '55x55x65 cm', 'Delivered', '2023-10-08 20:25:00'),
(9, 10.5, '60x60x70 cm', 'Delivered', '2023-10-09 21:35:00'),
(10, 11.5, '65x65x75 cm', 'Delivered', '2023-10-10 22:45:00');

INSERT INTO DELIVERY_REQUESTS (PackageID, PickupTime, DeliveryTime, Status, Fee) 
VALUES 
(1, '2023-10-01 13:00:00', '2023-10-01 13:45:00', 'Completed', 2.00),
(2, '2023-10-02 13:30:00', '2023-10-02 14:15:00', 'Completed', 3.00),
(3, '2023-10-03 14:00:00', '2023-10-03 14:45:00', 'Completed', 4.00),
(4, '2023-10-04 15:00:00', '2023-10-04 15:45:00', 'Completed', 5.00),
(5, '2023-10-05 16:00:00', '2023-10-05 16:45:00', 'Completed', 6.00),
(6, '2023-10-06 17:00:00', '2023-10-06 17:45:00', 'Completed', 7.00),
(7, '2023-10-07 18:00:00', '2023-10-07 18:45:00', 'Completed', 8.00),
(8, '2023-10-08 19:00:00', '2023-10-08 19:45:00', 'Completed', 9.00),
(9, '2023-10-09 20:00:00', '2023-10-09 20:45:00', 'Completed', 10.00),
(10, '2023-10-10 21:00:00', '2023-10-10 21:45:00', 'Completed', 11.00);

INSERT INTO DELIVERY_DRIVERS (RequestID, DriverID) 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO TRANSACTIONS (RequestID, Amount, PaymentMethod, PaymentStatus, TransactionDate) 
VALUES 
(1, 15.99, 'UPI', 'Successful', '2023-10-01 14:00:00'),
(2, 20.99, 'Card', 'Successful', '2023-10-02 15:00:00'),
(3, 25.99, 'Cash', 'Successful', '2023-10-03 16:00:00'),
(4, 30.99, 'UPI', 'Successful', '2023-10-04 17:00:00'),
(5, 35.99, 'Card', 'Successful', '2023-10-05 18:00:00'),
(6, 40.99, 'Cash', 'Successful', '2023-10-06 19:00:00'),
(7, 45.99, 'UPI', 'Successful', '2023-10-07 20:00:00'),
(8, 50.99, 'Card', 'Successful', '2023-10-08 21:00:00'),
(9, 55.99, 'Cash', 'Successful', '2023-10-09 22:00:00'),
(10, 60.99, 'UPI', 'Successful', '2023-10-10 23:00:00');

-- JOIN
SELECT o.OrderID, u.Name AS CustomerName, o.OrderTime FROM ORDERS o JOIN USERS u ON o.CustomerID = u.UserID;

SELECT p.PackageID, o.OrderID, o.OrderAmount, p.PackagingStatus FROM PACKAGES p JOIN ORDERS o ON p.OrderID = o.OrderID;

SELECT d.DriverID, u.Name, vt.Type AS VehicleType FROM DRIVERS d JOIN USERS u ON d.UserID = u.UserID JOIN VEHICLE_TYPES vt ON d.VehicleTypeID = vt.VehicleTypeID;

SELECT r.RestaurantID, r.Name, cc.CategoryName AS Cuisine FROM RESTAURANTS r JOIN CUISINE_CATEGORIES cc ON r.CuisineID = cc.CuisineID;

SELECT dr.RequestID, u.Name AS DriverName, dr.Status FROM DELIVERY_REQUESTS dr JOIN DELIVERY_DRIVERS dd ON dr.RequestID = dd.RequestID JOIN DRIVERS d ON dd.DriverID = d.DriverID JOIN USERS u ON d.UserID = u.UserID;

SELECT t.TransactionID, t.PaymentMethod, t.Amount, t.PaymentStatus FROM TRANSACTIONS t JOIN DELIVERY_REQUESTS dr ON t.RequestID = dr.RequestID;

SELECT o.OrderID, r.Name AS Restaurant, o.OrderAmount FROM ORDERS o JOIN RESTAURANTS r ON o.RestaurantID = r.RestaurantID;

SELECT d.DriverID, u.Name, vt.Type AS Vehicle FROM DRIVERS d JOIN USERS u ON d.UserID = u.UserID JOIN VEHICLE_TYPES vt ON d.VehicleTypeID = vt.VehicleTypeID WHERE d.AvailabilityStatus = 'Available';

SELECT p.PackageID, o.OrderID, p.Weight, p.Dimensions FROM PACKAGES p JOIN ORDERS o ON p.OrderID = o.OrderID WHERE p.PackagingStatus = 'Ready';

SELECT dr.RequestID, u.Name AS DriverName, dr.DeliveryTime FROM DELIVERY_REQUESTS dr JOIN DELIVERY_DRIVERS dd ON dr.RequestID = dd.RequestID JOIN DRIVERS d ON dd.DriverID = d.DriverID JOIN USERS u ON d.UserID = u.UserID WHERE dr.Status = 'Completed';

SELECT t.TransactionID, t.Amount, t.PaymentMethod FROM TRANSACTIONS t WHERE t.PaymentStatus = 'Successful';

SELECT r.Name AS Restaurant, u.Name AS Owner, u.Phone FROM RESTAURANTS r JOIN USERS u ON r.OwnerID = u.UserID;

SELECT o.OrderID, o.OrderAmount, dr.Status AS DeliveryStatus FROM ORDERS o JOIN PACKAGES p ON o.OrderID = p.OrderID JOIN DELIVERY_REQUESTS dr ON p.PackageID = dr.PackageID;

SELECT DISTINCT u.UserID, u.Name FROM USERS u JOIN ORDERS o ON u.UserID = o.CustomerID;

-- SUBQUERIES
SELECT u.UserID, u.Name FROM USERS u WHERE u.UserID NOT IN (SELECT CustomerID FROM ORDERS);

SELECT r.RestaurantID, r.Name FROM RESTAURANTS r WHERE r.RestaurantID NOT IN (SELECT RestaurantID FROM ORDERS);

SELECT d.DriverID, u.Name FROM DRIVERS d JOIN USERS u ON d.UserID = u.UserID WHERE d.DriverID NOT IN (SELECT dd.DriverID FROM DELIVERY_DRIVERS dd JOIN DELIVERY_REQUESTS dr ON dd.RequestID = dr.RequestID WHERE dr.Status = 'Completed');

SELECT OrderID, OrderAmount FROM ORDERS WHERE OrderAmount > (SELECT AVG(OrderAmount) FROM ORDERS);

SELECT OrderID, OrderAmount FROM ORDERS WHERE OrderAmount = (SELECT MAX(OrderAmount) FROM ORDERS);

SELECT u.UserID, u.Name FROM USERS u WHERE u.UserID IN (SELECT o.CustomerID FROM ORDERS o JOIN RESTAURANTS r ON o.RestaurantID = r.RestaurantID JOIN CUISINE_CATEGORIES cc ON r.CuisineID = cc.CuisineID WHERE cc.CategoryName = 'Italian');

SELECT PackageID, OrderID FROM PACKAGES WHERE PackagingStatus = 'Ready' AND PackageID IN (SELECT PackageID FROM DELIVERY_REQUESTS WHERE Status = 'Pending');

SELECT d.DriverID, u.Name FROM DRIVERS d JOIN USERS u ON d.UserID = u.UserID WHERE d.VehicleTypeID = (SELECT VehicleTypeID FROM VEHICLE_TYPES WHERE Type = 'Motorcycle');

SELECT OrderID, OrderTime FROM ORDERS WHERE OrderTime BETWEEN '2023-10-01' AND '2023-10-31';

SELECT RequestID, Fee FROM DELIVERY_REQUESTS WHERE Fee > (SELECT AVG(Fee) FROM DELIVERY_REQUESTS);

SELECT DISTINCT u.UserID, u.Name FROM USERS u JOIN ORDERS o ON u.UserID = o.CustomerID JOIN PACKAGES p ON o.OrderID = p.OrderID JOIN DELIVERY_REQUESTS dr ON p.PackageID = dr.PackageID JOIN TRANSACTIONS t ON dr.RequestID = t.RequestID WHERE t.PaymentMethod = 'UPI';

SELECT r.RestaurantID, r.Name FROM RESTAURANTS r WHERE (SELECT COUNT(*) FROM ORDERS o WHERE o.RestaurantID = r.RestaurantID) > 3;

SELECT d.DriverID, u.Name FROM DRIVERS d JOIN USERS u ON d.UserID = u.UserID WHERE d.DriverID = (SELECT dd.DriverID FROM DELIVERY_DRIVERS dd GROUP BY dd.DriverID ORDER BY COUNT(*) DESC LIMIT 1);

SELECT cc.CategoryName FROM CUISINE_CATEGORIES cc WHERE cc.CuisineID = (SELECT r.CuisineID FROM RESTAURANTS r JOIN ORDERS o ON r.RestaurantID = o.RestaurantID GROUP BY r.CuisineID ORDER BY COUNT(*) DESC LIMIT 1);

-- GROUP BY
SELECT UserType, COUNT(*) AS UserCount FROM USERS GROUP BY UserType;

SELECT c.CategoryName, COUNT(*) AS RestaurantCount FROM RESTAURANTS r JOIN CUISINE_CATEGORIES c ON r.CuisineID = c.CuisineID GROUP BY c.CategoryName;

SELECT r.Name, AVG(o.OrderAmount) AS AvgOrderValue FROM ORDERS o JOIN RESTAURANTS r ON o.RestaurantID = r.RestaurantID GROUP BY r.Name;

SELECT v.Type, COUNT(*) AS DriverCount FROM DRIVERS d JOIN VEHICLE_TYPES v ON d.VehicleTypeID = v.VehicleTypeID GROUP BY v.Type;

SELECT d.DriverID, u.Name, SUM(dr.Fee) AS TotalEarnings FROM DELIVERY_REQUESTS dr JOIN DELIVERY_DRIVERS dd ON dr.RequestID = dd.RequestID JOIN DRIVERS d ON dd.DriverID = d.DriverID JOIN USERS u ON d.UserID = u.UserID GROUP BY d.DriverID, u.Name;

SELECT Status, COUNT(*) AS OrderCount FROM ORDERS GROUP BY Status;

SELECT r.Name, AVG(p.Weight) AS AvgWeight FROM PACKAGES p JOIN ORDERS o ON p.OrderID = o.OrderID JOIN RESTAURANTS r ON o.RestaurantID = r.RestaurantID GROUP BY r.Name;

SELECT PaymentMethod, COUNT(*) AS TransactionCount FROM TRANSACTIONS GROUP BY PaymentMethod;

SELECT r.Name, COUNT(*) AS SuccessfulOrders FROM TRANSACTIONS t JOIN DELIVERY_REQUESTS dr ON t.RequestID = dr.RequestID JOIN PACKAGES p ON dr.PackageID = p.PackageID JOIN ORDERS o ON p.OrderID = o.OrderID JOIN RESTAURANTS r ON o.RestaurantID = r.RestaurantID WHERE t.PaymentStatus = 'Successful' GROUP BY r.Name;

SELECT HOUR(PickupTime) AS HourOfDay, COUNT(*) AS DeliveryCount FROM DELIVERY_REQUESTS GROUP BY HOUR(PickupTime);

SELECT d.DriverID, u.Name, AVG(TIMESTAMPDIFF(MINUTE, dr.PickupTime, dr.DeliveryTime)) AS AvgDeliveryMinutes FROM DELIVERY_REQUESTS dr JOIN DELIVERY_DRIVERS dd ON dr.RequestID = dd.RequestID JOIN DRIVERS d ON dd.DriverID = d.DriverID JOIN USERS u ON d.UserID = u.UserID WHERE dr.Status = 'Completed' GROUP BY d.DriverID, u.Name;

SELECT u.UserID, u.Name, SUM(o.OrderAmount) AS TotalSpent FROM USERS u JOIN ORDERS o ON u.UserID = o.CustomerID GROUP BY u.UserID, u.Name ORDER BY TotalSpent DESC;

SELECT PackagingStatus, COUNT(*) AS PackageCount FROM PACKAGES GROUP BY PackagingStatus;

SELECT Status, COUNT(*) AS RequestCount FROM DELIVERY_REQUESTS GROUP BY Status;

-- SELECT 
SELECT * FROM Orders WHERE OrderTime BETWEEN '2023-01-01' AND '2023-12-31';

SELECT * FROM Restaurants WHERE CuisineID IN (1, 3, 5);

-- UPDATE
UPDATE Orders SET Status = 'cancelled' WHERE OrderTime < '2023-06-01' AND Status = 'pending';

UPDATE Drivers SET AvailabilityStatus = 'Busy' WHERE UserId = 15;

-- DELETE
DELETE FROM TRANSACTIONS WHERE PaymentMethod = "UPI";

-- ALTER TABLE
ALTER TABLE DELIVERY_REQUESTS ADD COLUMN DeliveryNotes TEXT;

ALTER TABLE Orders ADD CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES Users(UserID);

-- VIEW
CREATE OR REPLACE VIEW ActiveCustomers AS SELECT * FROM Users WHERE UserID IN (SELECT DISTINCT CustomerID FROM Orders);

CREATE OR REPLACE VIEW RestaurantOrders AS SELECT r.Name, r.CuisineID, COUNT(o.OrderID) AS OrderCount FROM Restaurants r LEFT JOIN Orders o ON r.RestaurantID = o.RestaurantID GROUP BY r.Name, r.CuisineID;
