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
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| user_id | SERIAL | PRIMARY KEY | Auto-incremented unique identifier |
| name | VARCHAR(100) | NOT NULL | Full name of user |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Unique email address |
| password | VARCHAR(255) | NOT NULL | Hashed password for authentication |
| phone_number | VARCHAR(50) | | Contact phone number |
| role | VARCHAR(20) | CHECK('Admin','Customer') | User role in system |

### Vehicles Table
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| vehicle_id | SERIAL | PRIMARY KEY | Auto-incremented unique identifier |
| vehicle_name | VARCHAR(255) | NOT NULL | Name/model of vehicle |
| type | VARCHAR(20) | CHECK('Car','Bike','Truck') | Type of vehicle |
| model | VARCHAR(255) | | Model year/details |
| registration_number | VARCHAR(255) | UNIQUE, NOT NULL | Unique license plate number |
| rental_price_per_day | DECIMAL(8,2) | NOT NULL | Daily rental cost |
| availability_status | VARCHAR(20) | CHECK('Available','Rented','Maintenance') | Current availability status |

### Bookings Table
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| booking_id | SERIAL | PRIMARY KEY | Auto-incremented unique identifier |
| user_id | INT | FOREIGN KEY → Users(user_id) | Reference to user |
| vehicle_id | INT | FOREIGN KEY → Vehicles(vehicle_id) | Reference to vehicle |
| start_date | DATE | NOT NULL | Rental start date |
| end_date | DATE | NOT NULL | Rental end date |
| status | VARCHAR(20) | CHECK('Pending','Confirmed','Completed','Cancelled') | Booking status |
| total_cost | DECIMAL(8,2) | NOT NULL | Calculated total rental cost |

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


sql
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

sql
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

sql
SELECT 
    v.vehicle_name,  
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
LEFT JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2;
🚀 Installation & Setup
Prerequisites
PostgreSQL 12+ or MySQL 8+

SQL Client (Beekeeper Studio, pgAdmin, MySQL Workbench)

Git (for cloning repository)

Quick Start
Clone the repository:

bash
git clone https://github.com/yourusername/vehicle-rental-system.git
cd vehicle-rental-system
Execute the SQL file:

bash
# For PostgreSQL
psql -U username -d database_name -f queries.sql

# For MySQL
mysql -u username -p database_name < queries.sql
Or use your preferred SQL client to run queries.sql

Testing
Run individual queries from the SQL file to verify results match expected output.

📁 Sample Data
The database includes realistic sample data for testing:

Users
3 users (2 Customers, 1 Admin)

Unique emails and secure passwords

Vehicles
4 vehicles (2 cars, 1 bike, 1 truck)

Various availability statuses

Different rental prices

Bookings
4 booking records

Multiple status types (completed, confirmed, pending)

Realistic date ranges and costs

🔧 Technologies Used
Database: PostgreSQL/MySQL

ERD Tool: DrawSQL.app

SQL Client: Beekeeper Studio

Version Control: Git & GitHub

Documentation: Markdown

🏗️ Business Logic Implemented
User Management: Role-based access (Admin/Customer)

Vehicle Inventory: Unique registration numbers, availability tracking

Booking System: Date validation, status tracking, cost calculation

Data Integrity: Foreign key constraints, unique constraints, ENUM validation
