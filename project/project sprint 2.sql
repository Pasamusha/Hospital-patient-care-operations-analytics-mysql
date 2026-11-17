CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    city VARCHAR(50),
    patient_type VARCHAR(30),
    preferred_time_slot VARCHAR(30),
    registration_date DATE
);

CREATE TABLE doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50),
    hire_date DATE,
    rating DECIMAL(3,2),
    employment_type VARCHAR(30),
    is_active VARCHAR(5)
);
CREATE TABLE rooms (
    room_id VARCHAR(10) PRIMARY KEY,
    room_type VARCHAR(50),
    floor INT,
    equipment_type VARCHAR(50),
    capacity INT,
    last_maintenance_date DATE,
    is_available VARCHAR(5)
);

CREATE TABLE appointments (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10) NOT NULL,
    appointment_date DATE,
    doctor_id VARCHAR(10),
    service_type VARCHAR(50),
    priority VARCHAR(20),
    estimated_cost DECIMAL(10,2),
    booking_channel VARCHAR(30),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

CREATE TABLE treatments (
    treatment_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10) NOT NULL,
    doctor_id VARCHAR(10),
    room_id VARCHAR(10),
    actual_treatment_date DATE,
    status VARCHAR(30),
    treatment_attempt INT,
    treatment_duration_min INT,
    waiting_time_min INT,
    treatment_cost DECIMAL(10,2),

    FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),

    FOREIGN KEY (room_id)
        REFERENCES rooms(room_id)
);
show databases;
show tables;
Describe patients;
describe doctors;
drop database hospital;
select * from patients; 
select * from doctors;
select * from rooms;
select * from appointments;
select * from treatments;

-- Row Count
SELECT 'patients' AS table_name, COUNT(*) AS total_rows
FROM patients
UNION ALL
SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL
SELECT 'rooms', COUNT(*) FROM rooms
UNION ALL
SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'treatments', COUNT(*) FROM treatments;

-- Missing values
SELECT
    COUNT(*) AS total_rows,
    SUM(patient_id IS NULL) AS missing_patient_id,
    SUM(patient_name IS NULL) AS missing_patient_name,
    SUM(city IS NULL) AS missing_city
FROM patients;
SELECT
    COUNT(*) AS total_rows,
    SUM(patient_id IS NULL) AS missing_patient_id,
    SUM(doctor_id IS NULL) AS missing_doctor_id,
    SUM(appointment_date IS NULL) AS missing_appointment_date
FROM appointments;

-- Check missing treatment details
SELECT
    COUNT(*) AS total_rows,
    SUM(appointment_id IS NULL) AS missing_appointment_id,
    SUM(doctor_id IS NULL) AS missing_doctor_id,
    SUM(room_id IS NULL) AS missing_room_id,
    SUM(status IS NULL) AS missing_status
FROM treatments;

SELECT COUNT(*) AS unmatched_patients
FROM appointments a
LEFT JOIN patients p
    ON a.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

SELECT DISTINCT patient_type
FROM patients;