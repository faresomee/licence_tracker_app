-- Active: 1742868206282@@127.0.0.1@3306@traffic_db
/*


   _____ _____.___. _________________  .____      __________                   __               __   
  /     \\__  |   |/   _____/\_____  \ |    |     \______   \_______  ____    |__| ____   _____/  |_ 
 /  \ /  \/   |   |\_____  \  /  / \  \|    |      |     ___/\_  __ \/  _ \   |  |/ __ \_/ ___\   __\
/    Y    \____   |/        \/   \_/.  \    |___   |    |     |  | \(  <_> )  |  \  ___/\  \___|  |  
\____|__  / ______/_______  /\_____\ \_/_______ \  |____|     |__|   \____/\__|  |\___  >\___  >__|  
        \/\/              \/        \__>       \/                         \______|    \/     \/      


  Built with Passion by mohamedo7x
  Database : 
  Created on: 2025-02-13
*/

CREATE TABLE `Users` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `last_login` TIMESTAMP DEFAULT null,
  `active` BOOL,
  `username` VARCHAR(100) UNIQUE NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role_id` INT NOT NULL,
  `phone_number` VARCHAR(50),
  `img_profile` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT (now()),
  `updated_at` TIMESTAMP DEFAULT (now())
);


CREATE TABLE `Vehicles` (
  `id` INT PRIMARY KEY,
  `Manufacturer` VARCHAR(50) NOT NULL,
  `model` VARCHAR(50) NOT NULL,
  `color` VARCHAR(50) NOT NULL,
  `year` INT NOT NULL COMMENT 'Must be >= 1886'
);

CREATE TABLE `DriverVehicles` (
  `id` INT PRIMARY KEY,
  `driver_id` INT NOT NULL,
  `vehicle_id` INT NOT NULL,
  `assigned_date` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `Drivers` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `profile_img` VARCHAR(255),
  `dob` DATE NOT NULL,
  `issued_date` DATE NOT NULL,
  `expiry_date` DATE NOT NULL COMMENT 'Must be after issued_date',
  `created_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `LicensePlates` (
  `id` INT PRIMARY KEY,
  `plate_number` VARCHAR(20) UNIQUE NOT NULL,
  `vehicle_id` INT NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `Scans` (
  `id` INT PRIMARY KEY,
  `plate_id` INT NOT NULL,
  `scanned_by` INT NOT NULL,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  `timestamp` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `VehicleHistory` (
  `id` INT PRIMARY KEY,
  `plate_id` INT NOT NULL,
  `note` TEXT,
  `recorded_by` INT,
  `violation` INT,
  `license_id` INT,
  `created_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `DriverLicenses` (
  `id` INT PRIMARY KEY,
  `driver_id` INT NOT NULL,
  `license_number` VARCHAR(50) UNIQUE NOT NULL,
  `issued_date` DATE NOT NULL,
  `expiry_date` DATE NOT NULL COMMENT 'Must be after issued_date',
  `status` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT (now()),
  `updated_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `Violations` (
  `id` INT PRIMARY KEY,
  `scan_id` INT NOT NULL,
  `violation_type` VARCHAR(100) NOT NULL,
  `penalty_amount` DECIMAL(10,2) NOT NULL COMMENT 'Must be >= 0',
  `status` VARCHAR(255),
  `is_stolen` BOOLEAN DEFAULT false,
  `reported_by` INT NOT NULL,
  `license_id` INT,
  `notes` TEXT,
  `evidence_url` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT (now()),
  `updated_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `AuditLogs` (
  `id` INT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `action` TEXT NOT NULL,
  `timestamp` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `Notifications` (
  `id` INT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `message` TEXT,
  `created_at` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `Reports` (
  `id` INT PRIMARY KEY,
  `officer_id` INT NOT NULL,
  `details` TEXT NOT NULL,
  `report_date` TIMESTAMP DEFAULT (now())
);

CREATE TABLE `admin_users` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) UNIQUE NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255),
  `status` VARCHAR(255),
  `last_login` TIMESTAMP DEFAULT null,
  `created_at` TIMESTAMP DEFAULT (now()),
  `updated_at` TIMESTAMP
);

ALTER TABLE `Users` ADD FOREIGN KEY (`role_id`) REFERENCES `Roles` (`id`);

ALTER TABLE `DriverVehicles` ADD FOREIGN KEY (`driver_id`) REFERENCES `Drivers` (`id`);

ALTER TABLE `DriverVehicles` ADD FOREIGN KEY (`vehicle_id`) REFERENCES `Vehicles` (`id`);

ALTER TABLE `LicensePlates` ADD FOREIGN KEY (`vehicle_id`) REFERENCES `Vehicles` (`id`);

ALTER TABLE `Scans` ADD FOREIGN KEY (`plate_id`) REFERENCES `LicensePlates` (`id`);

ALTER TABLE `Scans` ADD FOREIGN KEY (`scanned_by`) REFERENCES `Users` (`id`);

ALTER TABLE `VehicleHistory` ADD FOREIGN KEY (`plate_id`) REFERENCES `LicensePlates` (`id`);

ALTER TABLE `VehicleHistory` ADD FOREIGN KEY (`recorded_by`) REFERENCES `Users` (`id`);

ALTER TABLE `VehicleHistory` ADD FOREIGN KEY (`violation`) REFERENCES `Violations` (`id`);

ALTER TABLE `VehicleHistory` ADD FOREIGN KEY (`license_id`) REFERENCES `DriverLicenses` (`id`);

ALTER TABLE `DriverLicenses` ADD FOREIGN KEY (`driver_id`) REFERENCES `Drivers` (`id`);

ALTER TABLE `Violations` ADD FOREIGN KEY (`scan_id`) REFERENCES `Scans` (`id`);

ALTER TABLE `Violations` ADD FOREIGN KEY (`reported_by`) REFERENCES `Users` (`id`);

ALTER TABLE `Violations` ADD FOREIGN KEY (`license_id`) REFERENCES `DriverLicenses` (`id`);

ALTER TABLE `AuditLogs` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Reports` ADD FOREIGN KEY (`officer_id`) REFERENCES `Users` (`id`);
