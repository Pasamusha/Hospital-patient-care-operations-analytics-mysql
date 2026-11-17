-- reatment performance and patient outcomes
-- For these queries, the key table is treatments.
--  We'll join it with appointments and patients to understand treatment outcomes by city, service, priority, and date.

-- Treatment count by status
SELECT status,COUNT(*) AS total_treatments,ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM treatments),2) AS percentage_of_treatments
FROM treatments
GROUP BY status
ORDER BY total_treatments DESC;
-- Treatment outcomes by city
SELECT p.city,t.status,COUNT(*) AS total_treatment FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.city, t.status
ORDER BY p.city, total_treatments DESC;
-- Treatment outcomes by service type
SELECT a.service_type,t.status,COUNT(*) AS total_treatments FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
GROUP BY a.service_type, t.status
ORDER BY a.service_type, total_treatments DESC;

-- Treatment outcomes by priority
SELECT a.priority,t.status,COUNT(*) AS total_treatments,ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
GROUP BY a.priority, t.status
ORDER BY a.priority, total_treatments DESC;
-- Average waiting time by city
SELECT p.city,COUNT(t.treatment_id) AS treatment_records,
    ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes,
    MAX(t.waiting_time_min) AS maximum_waiting_minutes
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.city
ORDER BY average_waiting_minutes DESC;
-- Monthly treatment performance
SELECT
    YEAR(actual_treatment_date) AS treatment_year,
    MONTH(actual_treatment_date) AS treatment_month,
    COUNT(*) AS total_treatment_records,
    ROUND(AVG(waiting_time_min), 2) AS average_waiting_minutes,
    ROUND(AVG(treatment_duration_min), 2) AS average_duration_minutes,
    ROUND(SUM(treatment_cost), 2) AS total_recorded_treatment_cost
FROM treatments
GROUP BY
    YEAR(actual_treatment_date),
    MONTH(actual_treatment_date)
ORDER BY treatment_year, treatment_month;

-- Treatments with long waiting times
SELECT t.treatment_id,t.appointment_id,p.patient_name,p.city,a.service_type,a.priority,t.waiting_time_min,t.status
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
WHERE t.waiting_time_min > 30
ORDER BY t.waiting_time_min DESC;
-- Treatment outcomes by patient type
SELECT p.patient_type,t.status,COUNT(*) AS total_treatment_records,
    ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.patient_type, t.status
ORDER BY p.patient_type, total_treatment_records DESC;
