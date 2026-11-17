-- Operational problems and repeated attempts
-- This section targets cancellations, no-shows, rescheduling, long waits, and repeated treatment attempts.

SELECT status, COUNT(*) AS record_count
FROM treatments
GROUP BY status
ORDER BY record_count DESC;

-- Count cancelled, no-show, rescheduled, and in-progress records
SELECT
    status,
    COUNT(*) AS total_records
FROM treatments
WHERE LOWER(status) IN (
    'cancelled',
    'no-show',
    'rescheduled',
    'in progress'
)
GROUP BY status
ORDER BY total_records DESC;

-- Cancellation and no-show records by city
SELECT p.city,t.status,COUNT(*) AS total_records FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
WHERE LOWER(t.status) IN ('cancelled', 'no-show')
GROUP BY p.city, t.status
ORDER BY total_records DESC;
-- Cancellation and no-show records by service
SELECT a.service_type,t.status,COUNT(*) AS total_records
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
WHERE LOWER(t.status) IN ('cancelled', 'no-show')
GROUP BY a.service_type, t.status
ORDER BY total_records DESC;

-- Rescheduled records by city and service
SELECT p.city,a.service_type,COUNT(*) AS rescheduled_records
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
JOIN patients p
    ON a.patient_id = p.patient_id
WHERE LOWER(t.status) = 'rescheduled'
GROUP BY p.city, a.service_type
ORDER BY rescheduled_records DESC;
-- Multiple attempts by treatment status
SELECT treatment_attempt,status,COUNT(*) AS treatment_records
FROM treatments
GROUP BY treatment_attempt, status
ORDER BY treatment_attempt, treatment_records DESC;

-- Waiting time by treatment attempt
SELECT treatment_attempt,COUNT(*) AS treatment_records,
    ROUND(AVG(waiting_time_min), 2) AS average_waiting_minutes,
    ROUND(AVG(treatment_duration_min), 2) AS average_duration_minutes
FROM treatments
GROUP BY treatment_attempt
ORDER BY treatment_attempt;

-- Cancellation and no-show records by priority
SELECT a.priority,t.status,COUNT(*) AS total_records,
    ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes
FROM treatments t
JOIN appointments a
    ON t.appointment_id = a.appointment_id
WHERE LOWER(t.status) IN ('cancelled', 'no-show')
GROUP BY a.priority, t.status
ORDER BY total_records DESC;