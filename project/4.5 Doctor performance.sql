-- E. Room and equipment utilization
-- Your dataset includes room type, floor, equipment type, capacity, maintenance date, and availability. 
-- It does not contain room booking hours, so we can measure recorded treatment usage, but not exact occupancy rates.

-- Treatment workload per room
SELECT r.room_id,r.room_type,r.floor,COUNT(t.treatment_id) AS treatment_records
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_id, r.room_type, r.floor
ORDER BY treatment_records DESC;
-- Treatment records by room type
SELECT r.room_type, COUNT(t.treatment_id) AS treatment_records,
    ROUND(AVG(t.treatment_duration_min), 2) AS average_duration_minutes,
    ROUND(AVG(t.waiting_time_min), 2) AS average_waiting_minutes
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.room_type
ORDER BY treatment_records DESC;
-- Equipment type and treatment usage
SELECT r.equipment_type,
    COUNT(t.treatment_id) AS treatment_records,
    COUNT(DISTINCT r.room_id) AS rooms_with_equipment
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
GROUP BY r.equipment_type
ORDER BY treatment_records DESC;
-- Rooms with no linked treatment records
SELECT r.room_id,r.room_type,r.floor,r.equipment_type,r.is_available
FROM rooms r
LEFT JOIN treatments t
    ON r.room_id = t.room_id
WHERE t.treatment_id IS NULL;
-- Room availability by room type
SELECT room_type,is_available,COUNT(*) AS total_rooms FROM rooms
GROUP BY room_type, is_available
ORDER BY room_type, total_rooms DESC;
-- Rooms whose last maintenance date is older than one year
SELECT room_id,room_type,floor,last_maintenance_date,
DATEDIFF(CURDATE(), last_maintenance_date) AS days_since_maintenance
FROM rooms
WHERE last_maintenance_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY last_maintenance_date;