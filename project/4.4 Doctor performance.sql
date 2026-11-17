-- D. Doctor performance
-- These queries explore workload, outcomes, ratings, treatment duration, and waiting time. 
-- Treat workload and outcome metrics as descriptive indicators, not proof of individual doctor quality.

-- Treatment workload per doctor
SELECT d.doctor_id,d.doctor_name,d.specialty,COUNT(t.treatment_id) AS total_treatment_records
FROM doctors d
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.specialty
ORDER BY total_treatment_records DESC;
-- Doctor outcomes by status
SELECT d.doctor_id,d.doctor_name, t.status,COUNT(*) AS total_treatment_records
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name, t.status
ORDER BY d.doctor_name, total_treatment_records DESC;
-- Average treatment duration by doctor
SELECT d.doctor_id,d.doctor_name,d.specialty,COUNT(t.treatment_id) AS treatment_records,
    ROUND(AVG(t.treatment_duration_min), 2) AS average_duration_minutes
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.specialty
ORDER BY average_duration_minutes DESC;

-- Average waiting time by doctor
SELECT d.doctor_id,d.doctor_name,COUNT(t.treatment_id) AS treatment_records,
    ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes
FROM doctors d
JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY average_waiting_minutes DESC;
-- Doctor rating compared with treatment workload
SELECT d.doctor_id,d.doctor_name,d.specialty,d.rating,COUNT(t.treatment_id) AS treatment_records
FROM doctors d
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.specialty,d.rating
ORDER BY d.rating DESC, treatment_records DESC;
-- Appointment demand compared with treatment records per doctor
SELECT d.doctor_id,d.doctor_name,COUNT(DISTINCT a.appointment_id) AS appointments_assigned,
    COUNT(DISTINCT t.treatment_id) AS treatment_records
FROM doctors d
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY appointments_assigned DESC;
-- Doctor workload by specialty
SELECT d.specialty,COUNT(DISTINCT d.doctor_id) AS total_doctors,
    COUNT(t.treatment_id) AS treatment_records,
    ROUND(AVG(t.treatment_duration_min), 2) AS average_duration_minutes
FROM doctors d
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY d.specialty
ORDER BY treatment_records DESC;
-- Inspect active doctors and their workloads
SELECT is_active, COUNT(*) AS doctor_count
FROM doctors
GROUP BY is_active;
