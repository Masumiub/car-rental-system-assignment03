# Vehicle Rental System - Database & SQL Assignment

## 📋 Project Overview
A comprehensive database solution for managing a vehicle rental business, including Entity Relationship Diagram (ERD) design, SQL schema implementation, and complex query writing. This project demonstrates practical database design skills and SQL query optimization.

## 🎯 Objectives
- Design an ERD with proper relationships (1-to-1, 1-to-Many)
- Implement a normalized database schema
- Write efficient SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING clauses
- Demonstrate understanding of relational database concepts

## 🗺️ ERD Design
The Entity Relationship Diagram illustrates the core structure of the Vehicle Rental System:

### Tables Structure:
1. **Users** - Stores customer and admin information
2. **Vehicles** - Manages vehicle inventory and availability
3. **Bookings** - Tracks rental transactions and status

### Relationships:
- **One-to-Many**: Users → Bookings (One user can have multiple bookings)
- **One-to-Many**: Vehicles → Bookings (One vehicle can have multiple bookings over time)
- **Logical Connection**: Each booking connects exactly one user and one vehicle

### Key Constraints:
- Primary Keys: `user_id`, `vehicle_id`, `booking_id`
- Foreign Keys: `user_id` in Bookings references Users, `vehicle_id` in Bookings references Vehicles
- Unique Constraints: `email` in Users, `registration_number` in Vehicles
- ENUM Constraints: Role, status, and type fields with predefined values

## 🗄️ Database Schema

### Users Table


### Vehicles Table


### Bookings Table


## 📊 SQL Queries Implementation

### Query 1: JOIN Operation
**Purpose**: Retrieve complete booking information with customer and vehicle details.


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
Query 2: EXISTS Operation
Purpose: Identify vehicles that have never been booked.


```sql
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
Query 3: WHERE Filtering
Purpose: Find all available vehicles of a specific type (e.g., cars).
```

```sql
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
Query 4: GROUP BY with HAVING
Purpose: Calculate booking frequency and identify popular vehicles.
```

```sql
SELECT 
    v.vehicle_name,  
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
LEFT JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2;
```


