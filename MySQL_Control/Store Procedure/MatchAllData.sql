CREATE DEFINER=`sql12746806`@`%` PROCEDURE `MatchAllData`()
BEGIN
    -- Xóa toàn bộ dữ liệu cũ và đặt lại AUTO_INCREMENT
    TRUNCATE TABLE sql12746806.MatchedAll;

    -- Chèn dữ liệu khớp từ PLC, RFID, và store
    INSERT INTO MatchedAll (plc_description, rfid_code, store_info, plc_timestamp, rfid_timestamp, store_timestamp)
    SELECT DISTINCT
        plc.PLC, rfid.RFID, s.store, plc.timestamp, rfid.timestamp, s.timestamp
    FROM PLC plc
    LEFT JOIN RFID rfid ON ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
    LEFT JOIN store s ON (
        (plc.PLC = 'dark-low' AND s.store = 'Kho 2' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 10)
        OR (plc.PLC = 'light-low' AND s.store = 'Kho 4' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 30)
        OR (plc.PLC = 'dark-high' AND s.store = 'Kho 9.2' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 50)
        OR (plc.PLC = 'light-high' AND s.store = 'Kho 9.1' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 58)
    )
    WHERE NOT EXISTS (
        SELECT 1 
        FROM MatchedAll ma
        WHERE ma.plc_description = plc.PLC
          AND ma.rfid_code = rfid.RFID
          AND ma.store_info = s.store
    );

    -- Chèn dữ liệu từ PLC không khớp với RFID
    INSERT INTO MatchedAll (plc_description, plc_timestamp)
    SELECT DISTINCT
        plc.PLC, plc.timestamp
    FROM PLC plc
    WHERE NOT EXISTS (
        SELECT 1 
        FROM RFID rfid 
        WHERE ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM MatchedAll ma
        WHERE ma.plc_description = plc.PLC AND ma.plc_timestamp = plc.timestamp
    );

    -- Chèn dữ liệu từ RFID không khớp với PLC
    INSERT INTO MatchedAll (rfid_code, rfid_timestamp)
    SELECT DISTINCT
        rfid.RFID, rfid.timestamp
    FROM RFID rfid
    WHERE NOT EXISTS (
        SELECT 1 
        FROM PLC plc 
        WHERE ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM MatchedAll ma
        WHERE ma.rfid_code = rfid.RFID AND ma.rfid_timestamp = rfid.timestamp
    );

    -- Chèn dữ liệu từ store không khớp
    INSERT INTO MatchedAll (store_info, store_timestamp)
    SELECT DISTINCT
        s.store, s.timestamp
    FROM store s
    WHERE NOT EXISTS (
        SELECT 1 
        FROM PLC plc
        JOIN RFID rfid ON ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
        WHERE (
            (plc.PLC = 'dark-low' AND s.store = 'Kho 2' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 10)
            OR (plc.PLC = 'light-low' AND s.store = 'Kho 4' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 30)
            OR (plc.PLC = 'dark-high' AND s.store = 'Kho 9.2' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 50)
            OR (plc.PLC = 'light-high' AND s.store = 'Kho 9.1' AND TIMESTAMPDIFF(SECOND, rfid.timestamp, s.timestamp) BETWEEN 0 AND 58)
        )
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM MatchedAll ma
        WHERE ma.store_info = s.store AND ma.store_timestamp = s.timestamp
    );
END