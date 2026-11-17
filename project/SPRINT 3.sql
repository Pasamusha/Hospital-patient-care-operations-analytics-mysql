USE hospital_db;
-- 1. Total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 2. Total number of appointments
SELECT COUNT(*) AS total_appointments
FROM appointments;

-- 3. Total number of treatment records
SELECT COUNT(*) AS total_treatments
FROM treatments;

-- 4. Different hospital services
SELECT DISTINCT service_type
FROM appointments;

-- 5. Number of active doctors
SELECT COUNT(*) AS active_doctors
FROM doctors
WHERE LOWER(is_active) = 'yes';

-- 6. Different room types
SELECT DISTINCT room_type
FROM rooms;

-- 7. Total estimated appointment value
SELECT SUM(estimated_cost) AS total_estimated_value
FROM appointments;

-- 8. Average treatment duration
SELECT AVG(treatment_duration_min) AS average_treatment_duration_minutes
FROM treatments;

-- 9.List all cities where patients live
SELECT DISTINCT city
FROM patients
ORDER BY city;

-- 10. List patient types
SELECT DISTINCT patient_type
FROM patients;

-- 9. List genders
SELECT DISTINCT gender
FROM patients;

-- 10. List preferred time slots
SELECT DISTINCT preferred_time_slot
FROM patients;

-- 11. List hospital service types
SELECT DISTINCT service_type
FROM appointments;

-- 12. List appointment priorities
SELECT DISTINCT priority
FROM appointments;

-- 13. List booking channels
SELECT DISTINCT booking_channel
FROM appointments;

-- 14. List treatment statuses
SELECT DISTINCT status
FROM treatments;

-- 15. List doctor specialties
SELECT DISTINCT specialty
FROM doctors;

-- 16. List employment types
SELECT DISTINCT employment_type
FROM doctors;

-- 17. List room types
SELECT DISTINCT room_type
FROM rooms;

-- 18. List equipment types
SELECT DISTINCT equipment_type
FROM rooms;

-- Total estimated appointment value
SELECT SUM(estimated_cost) AS total_estimated_value
FROM appointments;

-- 20. Average estimated appointment cost
SELECT ROUND(AVG(estimated_cost), 2) AS average_estimated_cost
FROM appointments;

-- 21. Highest estimated appointment cost
SELECT MAX(estimated_cost) AS highest_estimated_cost
FROM appointments;

-- 22. Lowest estimated appointment cost
SELECT MIN(estimated_cost) AS lowest_estimated_cost
FROM appointments;

-- 23. Total actual treatment cost
SELECT SUM(treatment_cost) AS total_treatment_cost
FROM treatments;

-- 24. Average treatment cost
SELECT ROUND(AVG(treatment_cost), 2) AS average_treatment_cost
FROM treatments;

-- 25. Highest treatment cost
SELECT MAX(treatment_cost) AS highest_treatment_cost
FROM treatments;

-- 26. Average treatment duration in minutes
SELECT ROUND(AVG(treatment_duration_min), 2)
       AS average_duration_minutes
FROM treatments;

-- 27. Longest treatment duration
SELECT MAX(treatment_duration_min) AS longest_duration_minutes
FROM treatments;

-- 28. Average patient waiting time
SELECT ROUND(AVG(waiting_time_min), 2)
       AS average_waiting_time_minutes
FROM treatments;

-- 29. Maximum patient waiting time
SELECT MAX(waiting_time_min) AS maximum_waiting_time_minutes
FROM treatments;

-- 30. Average patient age
SELECT ROUND(AVG(age), 2) AS average_patient_age
FROM patients;