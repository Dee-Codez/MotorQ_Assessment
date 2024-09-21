-- Create Owners table
CREATE TABLE IF NOT EXISTS Owners (
    owner_id INT PRIMARY KEY,
    owner_name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) NOT NULL
);

-- Seed one-time data into the Owners table
INSERT INTO Owners (owner_id, owner_name, contact_info) VALUES 
(1, 'John Doe', 'john.doe@example.com'), 
(2, 'Jane Smith', 'jane.smith@example.com'), 
(3, 'Alice Johnson', 'alice.johnson@example.com'), 
(4, 'Bob Brown', 'bob.brown@example.com'), 
(5, 'Charlie Davis', 'charlie.davis@example.com'), 
(6, 'Eve White', 'eve.white@example.com');

-- Create Vehicles table
CREATE TABLE IF NOT EXISTS Vehicles (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    manufacture_year INT NOT NULL,
    fuel_type VARCHAR(50) NOT NULL,
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

-- Seed one-time data into the Vehicles table
INSERT INTO Vehicles (vehicle_id, make, model, manufacture_year, fuel_type, owner_id) VALUES 
(1, 'Toyota', 'Camry', 2015, 'Petrol', 1), 
(2, 'Honda', 'Civic', 2018, 'Diesel', 2), 
(3, 'Ford', 'Focus', 2017, 'Petrol', 3), 
(4, 'Chevrolet', 'Malibu', 2016, 'Petrol', 4), 
(5, 'Nissan', 'Altima', 2019, 'Diesel', 5), 
(6, 'Hyundai', 'Elantra', 2020, 'Petrol', 6), 
(7, 'BMW', '3 Series', 2015, 'Diesel', 1), 
(8, 'Audi', 'A4', 2018, 'Petrol', 2), 
(9, 'Mercedes-Benz', 'C-Class', 2017, 'Diesel', 3), 
(10, 'Volkswagen', 'Passat', 2016, 'Petrol', 4), 
(11, 'Subaru', 'Impreza', 2019, 'Diesel', 5), 
(12, 'Mazda', '3', 2020, 'Petrol', 6), 
(13, 'Kia', 'Optima', 2015, 'Diesel', 1), 
(14, 'Lexus', 'IS', 2018, 'Petrol', 2), 
(15, 'Tesla', 'Model 3', 2021, 'Electric', 3);


-- Create Trips table
CREATE TABLE IF NOT EXISTS Trips (
    trip_id INT PRIMARY KEY,
    vehicle_id INT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    start_location VARCHAR(255) NOT NULL,
    end_location VARCHAR(255) NOT NULL,
    distance_traveled DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Create Trips table
CREATE TABLE IF NOT EXISTS Trips (
    trip_id INT PRIMARY KEY,
    vehicle_id INT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    start_location VARCHAR(255) NOT NULL,
    end_location VARCHAR(255) NOT NULL,
    distance_traveled DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Seed one-time data into the Trips table
INSERT INTO Trips (trip_id, vehicle_id, start_time, end_time, start_location, end_location, distance_traveled) VALUES 
(1, 1, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'New York', 'Boston', 240.0), 
(2, 1, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Boston', 'New York', 240.0), 
(3, 1, '2023-09-03 08:00:00', '2023-09-03 10:00:00', 'New York', 'Philadelphia', 90.0), 
(4, 2, '2023-09-01 08:00:00', '2023-09-01 16:00:00', 'Los Angeles', 'San Francisco', 360.0), 
(5, 2, '2023-09-02 08:00:00', '2023-09-02 16:00:00', 'San Francisco', 'Los Angeles', 360.0), 
(6, 2, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Los Angeles', 'San Diego', 120.0), 
(7, 3, '2023-09-01 08:00:00', '2023-09-01 14:00:00', 'Chicago', 'Detroit', 300.0), 
(8, 3, '2023-09-02 08:00:00', '2023-09-02 14:00:00', 'Detroit', 'Chicago', 300.0), 
(9, 3, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Chicago', 'Indianapolis', 180.0), 
(10, 4, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Houston', 'Dallas', 240.0), 
(11, 4, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Dallas', 'Houston', 240.0), 
(12, 4, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Houston', 'Austin', 180.0), 
(13, 5, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Miami', 'Orlando', 240.0), 
(14, 5, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Orlando', 'Miami', 240.0), 
(15, 5, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Miami', 'Tampa', 180.0), 
(16, 6, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Seattle', 'Portland', 180.0), 
(17, 6, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Portland', 'Seattle', 180.0), 
(18, 6, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Seattle', 'Vancouver', 150.0), 
(19, 7, '2023-09-01 08:00:00', '2023-09-01 14:00:00', 'Denver', 'Salt Lake City', 370.0), 
(20, 7, '2023-09-02 08:00:00', '2023-09-02 14:00:00', 'Salt Lake City', 'Denver', 370.0), 
(21, 7, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Denver', 'Colorado Springs', 70.0), 
(22, 8, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Phoenix', 'Tucson', 120.0), 
(23, 8, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Tucson', 'Phoenix', 120.0), 
(24, 8, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Phoenix', 'Flagstaff', 140.0), 
(25, 9, '2023-09-01 08:00:00', '2023-09-01 14:00:00', 'Atlanta', 'Nashville', 250.0), 
(26, 9, '2023-09-02 08:00:00', '2023-09-02 14:00:00', 'Nashville', 'Atlanta', 250.0), 
(27, 9, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Atlanta', 'Charlotte', 240.0), 
(28, 10, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'San Antonio', 'Houston', 200.0), 
(29, 10, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Houston', 'San Antonio', 200.0), 
(30, 10, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'San Antonio', 'Austin', 80.0), 
(31, 11, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Las Vegas', 'Los Angeles', 270.0), 
(32, 11, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Los Angeles', 'Las Vegas', 270.0), 
(33, 11, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Las Vegas', 'Phoenix', 300.0), 
(34, 12, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Portland', 'Seattle', 180.0), 
(35, 12, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Seattle', 'Portland', 180.0), 
(36, 12, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Portland', 'San Francisco', 630.0), 
(37, 13, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'Dallas', 'Houston', 240.0), 
(38, 13, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Houston', 'Dallas', 240.0), 
(39, 13, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'Dallas', 'Austin', 180.0), 
(40, 14, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'San Francisco', 'Los Angeles', 360.0), 
(41, 14, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Los Angeles', 'San Francisco', 360.0), 
(42, 14, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'San Francisco', 'San Diego', 500.0), 
(43, 15, '2023-09-01 08:00:00', '2023-09-01 12:00:00', 'New York', 'Washington D.C.', 225.0), 
(44, 15, '2023-09-02 08:00:00', '2023-09-02 12:00:00', 'Washington D.C.', 'New York', 225.0), 
(45, 15, '2023-09-03 08:00:00', '2023-09-03 12:00:00', 'New York', 'Boston', 240.0);

-- Create Sensors table
CREATE TABLE IF NOT EXISTS Sensors (
    sensor_id INT PRIMARY KEY,
    vehicle_id INT,
    sensor_type VARCHAR(255) NOT NULL,
    sensor_reading DECIMAL(10, 2) NOT NULL,
    reading_timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Seed one-time data into the Sensors table
INSERT INTO Sensors (sensor_id, vehicle_id, sensor_type, sensor_reading, reading_timestamp) VALUES 
(1, 1, 'Fuel Level', 75.5, '2023-01-01 08:00:00'), 
(2, 1, 'Speed', 60.0, '2023-01-01 08:30:00'), 
(3, 2, 'Fuel Level', 180.0, '2023-01-02 09:00:00'), 
(4, 2, 'Speed', 65.0, '2023-01-02 09:30:00'), 
(5, 3, 'Fuel Level', 70.0, '2023-01-03 10:00:00'), 
(6, 3, 'Speed', 55.0, '2023-01-03 10:30:00'), 
(7, 4, 'Fuel Level', 8.0, '2023-01-04 11:00:00'), 
(8, 4, 'Speed', 50.0, '2023-01-04 11:30:00'), 
(9, 5, 'Fuel Level', 72.0, '2023-01-05 12:00:00'), 
(10, 5, 'Speed', 58.0, '2023-01-05 12:30:00'), 
(11, 6, 'Fuel Level', 74.0, '2023-01-06 13:00:00'), 
(12, 6, 'Speed', 62.0, '2023-01-06 13:30:00'), 
(13, 7, 'Fuel Level', 76.0, '2023-01-07 14:00:00'), 
(14, 7, 'Speed', 164.0, '2023-01-07 14:30:00'), 
(15, 8, 'Fuel Level', 78.0, '2023-01-08 15:00:00'), 
(16, 8, 'Speed', 66.0, '2023-01-08 15:30:00'), 
(17, 9, 'Fuel Level', 77.0, '2023-01-09 16:00:00'), 
(18, 9, 'Speed', 63.0, '2023-01-09 16:30:00'), 
(19, 10, 'Fuel Level', 79.0, '2023-01-10 17:00:00'), 
(20, 10, 'Speed', 67.0, '2023-01-10 17:30:00'), 
(21, 11, 'Fuel Level', 81.0, '2023-01-11 18:00:00'), 
(22, 11, 'Speed', 169.0, '2023-01-11 18:30:00'), 
(23, 12, 'Fuel Level', 82.0, '2023-01-12 19:00:00'), 
(24, 12, 'Speed', 70.0, '2023-01-12 19:30:00'), 
(25, 13, 'Fuel Level', 83.0, '2023-01-13 20:00:00'), 
(26, 13, 'Speed', 71.0, '2023-01-13 20:30:00'), 
(27, 14, 'Fuel Level', 84.0, '2023-01-14 21:00:00'), 
(28, 14, 'Speed', 72.0, '2023-01-14 21:30:00'), 
(29, 15, 'Fuel Level', 5.0, '2023-01-15 22:00:00'), 
(30, 15, 'Speed', 73.0, '2023-01-15 22:30:00');

-- Create Maintenance table
CREATE TABLE IF NOT EXISTS Maintenance (
    maintenance_id INT PRIMARY KEY,
    vehicle_id INT,
    maintenance_type VARCHAR(255) NOT NULL,
    maintenance_date DATE NOT NULL,
    maintenance_cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Seed one-time data into the Maintenance table
INSERT INTO Maintenance (maintenance_id, vehicle_id, maintenance_type, maintenance_date, maintenance_cost) VALUES 
(1, 1, 'Oil Change', '2023-01-01', 50.00), 
(2, 1, 'Tire Rotation', '2023-02-01', 30.00), 
(3, 1, 'Brake Inspection', '2023-03-01', 70.00), 
(4, 2, 'Oil Change', '2023-01-02', 50.00), 
(5, 2, 'Tire Rotation', '2023-02-02', 30.00), 
(6, 2, 'Brake Inspection', '2023-03-02', 70.00), 
(7, 3, 'Oil Change', '2023-01-03', 50.00), 
(8, 3, 'Tire Rotation', '2023-02-03', 30.00), 
(9, 3, 'Brake Inspection', '2023-03-03', 70.00), 
(10, 4, 'Oil Change', '2023-01-04', 50.00), 
(11, 4, 'Tire Rotation', '2023-02-04', 30.00), 
(12, 4, 'Brake Inspection', '2023-03-04', 70.00), 
(13, 5, 'Oil Change', '2023-01-05', 50.00), 
(14, 5, 'Tire Rotation', '2023-02-05', 30.00), 
(15, 5, 'Brake Inspection', '2023-03-05', 70.00), 
(16, 6, 'Oil Change', '2023-01-06', 50.00), 
(17, 6, 'Tire Rotation', '2023-02-06', 30.00), 
(18, 6, 'Brake Inspection', '2023-03-06', 70.00), 
(19, 7, 'Oil Change', '2023-01-07', 50.00), 
(20, 7, 'Tire Rotation', '2023-02-07', 30.00), 
(21, 7, 'Brake Inspection', '2023-03-07', 70.00), 
(22, 8, 'Oil Change', '2023-01-08', 50.00), 
(23, 8, 'Tire Rotation', '2023-02-08', 30.00), 
(24, 8, 'Brake Inspection', '2023-03-08', 70.00), 
(25, 9, 'Oil Change', '2023-01-09', 50.00), 
(26, 9, 'Tire Rotation', '2023-02-09', 30.00), 
(27, 9, 'Brake Inspection', '2023-03-09', 70.00), 
(28, 10, 'Oil Change', '2023-01-10', 50.00), 
(29, 10, 'Tire Rotation', '2023-02-10', 30.00), 
(30, 10, 'Brake Inspection', '2023-03-10', 70.00), 
(31, 11, 'Oil Change', '2023-01-11', 50.00), 
(32, 11, 'Tire Rotation', '2023-02-11', 30.00), 
(33, 11, 'Brake Inspection', '2023-03-11', 70.00), 
(34, 12, 'Oil Change', '2023-01-12', 50.00), 
(35, 12, 'Tire Rotation', '2023-02-12', 30.00), 
(36, 12, 'Brake Inspection', '2023-03-12', 70.00), 
(37, 13, 'Oil Change', '2023-01-13', 50.00), 
(38, 13, 'Tire Rotation', '2023-02-13', 30.00), 
(39, 13, 'Brake Inspection', '2023-03-13', 70.00), 
(40, 14, 'Oil Change', '2023-01-14', 50.00), 
(41, 14, 'Tire Rotation', '2023-02-14', 30.00), 
(42, 14, 'Brake Inspection', '2023-03-14', 70.00), 
(43, 15, 'Oil Change', '2023-01-15', 50.00), 
(44, 15, 'Tire Rotation', '2023-02-15', 30.00), 
(45, 15, 'Brake Inspection', '2023-03-15', 70.00);