-- Create Owners table
CREATE TABLE IF NOT EXISTS Owners (
    owner_id INT PRIMARY KEY,
    owner_name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) NOT NULL
);

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

-- Create Sensors table
CREATE TABLE IF NOT EXISTS Sensors (
    sensor_id INT PRIMARY KEY,
    vehicle_id INT,
    sensor_type VARCHAR(255) NOT NULL,
    sensor_reading DECIMAL(10, 2) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Create Maintenance table
CREATE TABLE IF NOT EXISTS Maintenance (
    maintenance_id INT PRIMARY KEY,
    vehicle_id INT,
    maintenance_type VARCHAR(255) NOT NULL,
    maintenance_date DATE NOT NULL,
    maintenance_cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);