CREATE DEFINER=`sql12746806`@`%` PROCEDURE `FilterNonNullDataAll`()
BEGIN
    -- Xóa dữ liệu cũ trong NonNullMatchedAll để đảm bảo không bị trùng lặp
     TRUNCATE TABLE NonNullMatchedAll;

    -- Lấy toàn bộ dữ liệu không có giá trị NULL từ MatchedAll
    INSERT INTO NonNullMatchedAll (plc_description, rfid_code, store_info, plc_timestamp, rfid_timestamp, store_timestamp)
    SELECT 
        plc_description,
        rfid_code,
        store_info,
        plc_timestamp,
        rfid_timestamp,
        store_timestamp
    FROM 
        MatchedAll
    WHERE 
        plc_description IS NOT NULL AND
        rfid_code IS NOT NULL AND
        store_info IS NOT NULL AND
        plc_timestamp IS NOT NULL AND
        rfid_timestamp IS NOT NULL AND
        store_timestamp IS NOT NULL;
END