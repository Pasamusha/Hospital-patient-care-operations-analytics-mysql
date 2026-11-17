USE hospital_db;
-- Analyze Patients

-- 1. Number of patients by city
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

-- 2. Number of patients by gender
SELECT gender, COUNT(*) AS total_patients
FROM patients
GROUP BY gender
ORDER BY total_patients DESC;

-- 3. Number of patients by patient type
SELECT patient_type, COUNT(*) AS total_patients
FROM patients
GROUP BY patient_type
ORDER BY total_patients DESC;

-- 4. Number of patients by preferred time slot
SELECT preferred_time_slot, COUNT(*) AS total_patients
FROM patients
GROUP BY preferred_time_slot
ORDER BY total_patients DESC;

-- 5. Youngest and oldest patient ages
SELECT
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM patients;

-- 6. Patients aged 60 or above
SELECT patient_id, patient_name, age, city
FROM patients
WHERE age >= 60
ORDER BY age DESC;

-- 7. Patients registered most recently
SELECT patient_id, patient_name, registration_date
FROM patients
ORDER BY registration_date DESC
LIMIT 10;

-- 8. Patients with the same name
SELECT patient_name, COUNT(*) AS name_count
FROM patients
GROUP BY patient_name
HAVING COUNT(*) > 1
ORDER BY name_count DESC;

-- Analyze appointments
-- 9. Appointments by service type
SELECT service_type, COUNT(*) AS total_appointments
FROM appointments
GROUP BY service_type
ORDER BY total_appointments DESC;

-- 10. Appointments by priority
SELECT priority, COUNT(*) AS total_appointments
FROM appointments
GROUP BY priority
ORDER BY total_appointments DESC;

-- 11. Appointments by booking channel
SELECT booking_channel, COUNT(*) AS total_appointments
FROM appointments
GROUP BY booking_channel
ORDER BY total_appointments DESC;

-- 12. Appointments by city
SELECT p.city, COUNT(*) AS total_appointments
FROM appointments a
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.city
ORDER BY total_appointments DESC;

-- 13. Appointments by patient type
SELECT p.patient_type, COUNT(*) AS total_appointments
FROM appointments a
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.patient_type
ORDER BY total_appointments DESC;

-- 14. Appointments by appointment date
SELECT appointment_date, COUNT(*) AS total_appointments
FROM appointments
GROUP BY appointment_date
ORDER BY appointment_date;

-- 15. Ten most expensive estimated appointments
SELECT appointment_id, patient_id, service_type, estimated_cost
FROM appointments
ORDER BY estimated_cost DESC
LIMIT 10;

-- 16. Appointments costing more than the average
SELECT appointment_id, patient_id, service_type, estimated_cost
FROM appointments
WHERE estimated_cost > (
    SELECT AVG(estimated_cost)
    FROM appointments
)
ORDER BY estimated_cost DESC;

-- 17. Patients who have never booked an appointment
SELECT p.patient_id, p.patient_name
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- Analyze doctors and rooms

-- 18. Number of doctors by specialty
SELECT specialty, COUNT(*) AS total_doctors
FROM doctors
GROUP BY specialty
ORDER BY total_doctors DESC;

-- 19. Doctors by employment type
SELECT employment_type, COUNT(*) AS total_doctors
FROM doctors
GROUP BY employment_type;

-- 20. Inspect actual active-status values
SELECT is_active, COUNT(*) AS total_doctors
FROM doctors
GROUP BY is_active;

-- 21. Average doctor rating by specialty
SELECT specialty, ROUND(AVG(rating), 2) AS average_rating
FROM doctors
GROUP BY specialty
ORDER BY average_rating DESC;

-- 22. Number of rooms by room type
SELECT room_type, COUNT(*) AS total_rooms
FROM rooms
GROUP BY room_type
ORDER BY total_rooms DESC;

-- 23. Number of rooms by floor
SELECT floor, COUNT(*) AS total_rooms
FROM rooms
GROUP BY floor
ORDER BY floor;

-- 24. Rooms by equipment type
SELECT equipment_type, COUNT(*) AS total_rooms
FROM rooms
GROUP BY equipment_type
ORDER BY total_rooms DESC;

-- 25. Inspect actual room availability values
SELECT is_available, COUNT(*) AS total_rooms
FROM rooms
GROUP BY is_available;

-- Analyze treatment operations

-- 26. Number of treatments by status
SELECT status, COUNT(*) AS total_treatments
FROM treatments
GROUP BY status
ORDER BY total_treatments DESC;
-- 27. Average treatment duration by status
SELECT status,ROUND(AVG(treatment_duration_min), 2) AS average_duration
FROM treatments
GROUP BY status
ORDER BY average_duration DESC;
-- 28. Average waiting time by status
SELECT status,ROUND(AVG(waiting_time_min), 2) AS average_waiting_minutes
FROM treatments
GROUP BY status
ORDER BY average_waiting_minutes DESC;

-- 29. Treatments by doctor
SELECT d.doctor_id,d.doctor_name,COUNT(t.treatment_id) AS total_treatments
FROM doctors d
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY total_treatments DESC;

-- 30. Treatments by room
SELECT r.room_id, r.room_type,COUNT(t.treatment_id) AS total_treatments FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_id, r.room_type
ORDER BY total_treatments DESC;

-- 31. Treatments by treatment date
SELECT actual_treatment_date,COUNT(*) AS total_treatments
FROM treatments
GROUP BY actual_treatment_date
ORDER BY actual_treatment_date;

-- 32. Treatment attempts by attempt number
SELECT treatment_attempt, COUNT(*) AS total_treatment FROM treatments
GROUP BY treatment_attempt
ORDER BY treatment_attempt;

-- 33. Treatments with waiting time greater than 30 minutes
SELECT treatment_id,appointment_id,waiting_time_min,status FROM treatments
WHERE waiting_time_min > 30
ORDER BY waiting_time_min DESC;

-- 34. Treatments with duration greater than 60 minutes
SELECT treatment_id,appointment_id,treatment_duration_min,status
FROM treatments
WHERE treatment_duration_min > 60
ORDER BY treatment_duration_min DESC;

-- 35. Ten most expensive actual treatments
SELECT treatment_id, appointment_id, treatment_cost,status FROM treatments
ORDER BY treatment_cost DESC
LIMIT 10;
