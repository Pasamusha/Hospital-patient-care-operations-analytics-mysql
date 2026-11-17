-- Appointment volume by city
SELECT p.city,COUNT(a.appointment_id) AS total_appointments FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY total_appointments DESC;

-- Appointment volume by service type
SELECT service_type, COUNT(*) AS total_appointments
FROM appointments
GROUP BY service_type
ORDER BY total_appointments DESC;

-- Appointment volume by priority
SELECT priority, COUNT(*) AS total_appointments,
    ROUND(AVG(estimated_cost), 2) AS average_estimated_cost
FROM appointments
GROUP BY priority
ORDER BY total_appointments DESC;
-- . Appointment demand by city and service
SELECT p.city, a.service_type, COUNT(*) AS total_appointments
FROM appointments a
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.city, a.service_type
ORDER BY p.city, total_appointments DESC;
-- Appointment demand by city and priority
SELECT p.city, a.priority,COUNT(*) AS total_appointments
FROM appointments a
JOIN patients p
    ON a.patient_id = p.patient_id
GROUP BY p.city, a.priority
ORDER BY p.city, total_appointments DESC;
-- Appointment volume over time
SELECT
    YEAR(appointment_date) AS appointment_year,
    MONTH(appointment_date) AS appointment_month,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)
ORDER BY appointment_year, appointment_month;

-- Appointment demand by weekday
SELECT
    DAYNAME(appointment_date) AS weekday_name,
    DAYOFWEEK(appointment_date) AS weekday_number,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY
    DAYNAME(appointment_date),
    DAYOFWEEK(appointment_date)
ORDER BY weekday_number;

-- Appointment demand by booking channel
SELECT booking_channel,COUNT(*) AS total_appointments,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM appointments),2) AS percentage_of_appointments
FROM appointments
GROUP BY booking_channel
ORDER BY total_appointments DESC;

-- Estimated appointment value by patient type
SELECT
    p.patient_type,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(a.estimated_cost), 2) AS total_estimated_value,
    ROUND(AVG(a.estimated_cost), 2) AS average_estimated_cost
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_type
ORDER BY total_estimated_value DESC;

-- Estimated appointment value by city
SELECT
    p.city,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(a.estimated_cost), 2) AS total_estimated_value,
    ROUND(AVG(a.estimated_cost), 2) AS average_estimated_cost
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.city
ORDER BY total_estimated_value DESC;

-- Most expensive services by total estimated value
SELECT service_type, COUNT(*) AS total_appointments,
    ROUND(SUM(estimated_cost), 2) AS total_estimated_value
FROM appointments
GROUP BY service_type
ORDER BY total_estimated_value DESC;

-- High-priority appointments by booking channel
SELECT
    booking_channel,
    priority,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY booking_channel, priority
ORDER BY booking_channel, total_appointments DESC;

-- . Monthly appointment value trends
SELECT
    YEAR(appointment_date) AS appointment_year,
    MONTH(appointment_date) AS appointment_month,
    COUNT(*) AS total_appointments,
    ROUND(SUM(estimated_cost), 2) AS monthly_estimated_value,
    ROUND(AVG(estimated_cost), 2) AS average_estimated_cost
FROM appointments
GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)
ORDER BY appointment_year, appointment_month;
-- Appointments by patient age group
SELECT
    CASE
        WHEN p.age < 18 THEN 'Under 18'
        WHEN p.age BETWEEN 18 AND 29 THEN '18-29'
        WHEN p.age BETWEEN 30 AND 44 THEN '30-44'
        WHEN p.age BETWEEN 45 AND 59 THEN '45-59'
        WHEN p.age >= 60 THEN '60+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY age_group
ORDER BY total_appointments DESC;