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
https://lucid.app/lucidchart/c2c8d97e-3d29-4ad4-bd71-2b3d03b80d24/edit?viewport_loc=-255%2C-199%2C1698%2C1959%2C0_0&invitationId=inv_88150742-2918-4e4f-be8a-35b0bbcc3a5d
<img width="893" height="728" alt="Image" src="https://github.com/user-attachments/assets/5258f699-667f-4a86-aab4-fadc2b8b41a2" />


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
<img width="663" height="134" alt="Image" src="https://github.com/user-attachments/assets/1562e9d9-73b6-47af-841b-bf3eef39d82a" />

### Vehicles Table
<img width="721" height="148" alt="Image" src="https://github.com/user-attachments/assets/b53fc283-b6c4-40f7-a6f4-2d9b67d307bd" />

### Bookings Table
<img width="665" height="156" alt="Image" src="https://github.com/user-attachments/assets/f12eb733-eaee-499b-a69a-f78fae2d1d0e" />

## 📊 SQL Queries Implementation

### Query 1: JOIN Operation
**Purpose**: Retrieve complete booking information with customer and vehicle details.

```sql
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
```
<img width="662" height="168" alt="Image" src="https://github.com/user-attachments/assets/ab75dd06-8e66-4a9f-a1cd-673a251ae270" />



### Query 2: EXISTS Operation
**Purpose**: Identify vehicles that have never been booked.
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
```
<img width="743" height="104" alt="Image" src="https://github.com/user-attachments/assets/f43fb57b-db40-4583-9315-712d9046c86c" />


### Query 3: WHERE Filtering
**Purpose**: Find all available vehicles of a specific type (e.g., cars).
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
```
<img width="713" height="75" alt="Image" src="https://github.com/user-attachments/assets/495dd16f-0109-4f0e-9915-25811c08a24c" />


### Query 4: GROUP BY with HAVING
**Purpose**: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
```sql
SELECT 
    v.vehicle_name,  
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
LEFT JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2;
```
<img width="272" height="73" alt="Image" src="https://github.com/user-attachments/assets/6ed67323-5339-4323-9f09-6751745574ef" />


