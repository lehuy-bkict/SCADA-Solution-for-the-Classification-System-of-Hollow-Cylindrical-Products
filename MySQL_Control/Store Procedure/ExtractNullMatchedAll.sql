CREATE DEFINER=`sql12746806`@`%` PROCEDURE `ExtractNullMatchedAll`()
BEGIN
	TRUNCATE TABLE NullMatchedAll;
    INSERT INTO NullMatchedAll (plc_description, rfid_code, store_info, plc_timestamp, rfid_timestamp, store_timestamp)
    SELECT 
        plc_description,
        rfid_code,
        store_info,
        plc_timestamp,
        rfid_timestamp,
        store_timestamp
    FROM MatchedAll
    WHERE 
        plc_description IS NULL OR
        rfid_code IS NULL OR
        store_info IS NULL OR
        plc_timestamp IS NULL OR
        rfid_timestamp IS NULL OR
        store_timestamp IS NULL;
END