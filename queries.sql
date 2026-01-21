-- Query 1: JOIN
SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;



-- Query 2: EXISTS
SELECT 
    v.vehicle_id,
    v.vehicle_name, 
    v.type,
    v.model,
    v.registration_number,
    v.rental_price_per_day AS rental_price,
    v.availability_status AS status
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);


-- Query 3: WHERE
SELECT 
    vehicle_id,
    vehicle_name AS name,  
    type,
    model,
    registration_number,
    rental_price_per_day AS rental_price,
    availability_status AS status
FROM Vehicles
WHERE type = 'car' 
AND availability_status = 'available';



-- Query 4: GROUP BY and HAVING
SELECT 
    v.vehicle_name,  
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
LEFT JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2;



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Commands for Creating Table
-- Create ENUM types
CREATE TYPE user_role AS ENUM ('Admin', 'Customer');
CREATE TYPE vehicle_type AS ENUM ('car', 'bike', 'truck');
CREATE TYPE available_status AS ENUM ('available', 'rented', 'maintenance');
CREATE TYPE book_status AS ENUM ('pending', 'confirmed', 'completed', 'cancelled');

-- Create Tables
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, 
    phone_number VARCHAR(15),
    role user_role DEFAULT 'Customer'
);

CREATE TABLE Vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_name VARCHAR(100) NOT NULL,
    type vehicle_type NOT NULL,
    model VARCHAR(50),
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    rental_price_per_day DECIMAL(10,2) NOT NULL,
    availability_status available_status DEFAULT 'available'
);

CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status book_status DEFAULT 'pending',
    total_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE,
    CONSTRAINT valid_dates CHECK (end_date >= start_date)
);



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Insert Data with 
INSERT INTO Users (name, email, password, phone_number, role) VALUES
('Alice', 'alice@example.com', 'hashed_password_123', '1234567890', 'Customer'),
('Bob', 'bob@example.com', 'hashed_password_456', '0987654321', 'Admin'),
('Charlie', 'charlie@example.com', 'hashed_password_789', '1122334455', 'Customer');

INSERT INTO Vehicles (vehicle_name, type, model, registration_number, rental_price_per_day, availability_status) VALUES
('Toyota Corolla', 'car', '2022', 'ABC-123', 50.00, 'available'),
('Honda Civic', 'car', '2021', 'DEF-456', 60.00, 'rented'),
('Yamaha R15', 'bike', '2023', 'GHI-789', 30.00, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100.00, 'maintenance');

INSERT INTO Bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240.00),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120.00),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60.00),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100.00);
