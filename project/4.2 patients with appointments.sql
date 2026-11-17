-- 4.2 Understand Patient Appointment Behaviour
-- These queries help identify repeat patients, highly active patients, patient spending patterns,
--  and registration-to-appointment behavior.

-- Number of appointments per patient
SELECT p.patient_id, p.patient_name,COUNT(a.appointment_id) AS total_appointments
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY total_appointments DESC;
-- Repeat patients
SELECT p.patient_id,p.patient_name,COUNT(a.appointment_id) AS total_appointments FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY total_appointments DESC;
-- Patients with the highest cumulative estimated appointment value
SELECT p.patient_id,p.patient_name,COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(a.estimated_cost), 2) AS cumulative_estimated_value
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY cumulative_estimated_value DESC
LIMIT 20;
-- Patients with no appointment records
SELECT p.patient_id,p.patient_name,p.registration_date,p.city FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;
-- Patient activity by city and patient type
SELECT p.city,p.patient_type,COUNT(DISTINCT p.patient_id) AS unique_patients,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city, p.patient_type
ORDER BY p.city, total_appointments DESC;
-- Monthly new patient registrations
SELECT YEAR(registration_date) AS registration_year,MONTH(registration_date) AS registration_month,COUNT(*) AS new_patients
FROM patients
GROUP BY
    YEAR(registration_date),MONTH(registration_date)
ORDER BY registration_year, registration_month;
-- . Patients' first and latest appointment dates
SELECT p.patient_id, p.patient_name,
    MIN(a.appointment_date) AS first_appointment_date,
    MAX(a.appointment_date) AS latest_appointment_date,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY latest_appointment_date DESC;

-- Patients with appointments across multiple service types
SELECT p.patient_id,p.patient_name,COUNT(DISTINCT a.service_type) AS different_services,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(DISTINCT a.service_type) > 1
ORDER BY different_services DESC, total_appointments DESC;