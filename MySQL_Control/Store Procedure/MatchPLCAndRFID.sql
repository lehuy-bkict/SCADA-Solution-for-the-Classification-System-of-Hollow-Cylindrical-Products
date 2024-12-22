CREATE DEFINER=`sql12746806`@`%` PROCEDURE `MatchPLCAndRFID`()
BEGIN
    -- Xóa dữ liệu cũ trong bảng MatchedData để tránh trùng lặp
    TRUNCATE TABLE sql12746806.MatchedData;

    -- Chèn dữ liệu khi khớp timestamp trong khoảng 5 giây
    INSERT INTO MatchedData (plc_description, rfid_code, plc_timestamp, rfid_timestamp)
    SELECT 
        plc.PLC AS plc_description,
        rfid.RFID AS rfid_code,
        plc.timestamp AS plc_timestamp,
        rfid.timestamp AS rfid_timestamp
    FROM 
        PLC plc
    LEFT JOIN 
        RFID rfid
    ON 
        ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5;

    -- Chèn dữ liệu từ PLC không khớp RFID
    INSERT INTO MatchedData (plc_description, rfid_code, plc_timestamp, rfid_timestamp)
    SELECT 
        plc.PLC AS plc_description,
        NULL AS rfid_code,
        plc.timestamp AS plc_timestamp,
        NULL AS rfid_timestamp
    FROM 
        PLC plc
    WHERE 
        NOT EXISTS (
            SELECT 1
            FROM RFID rfid
            WHERE ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
        );

    -- Chèn dữ liệu từ RFID không khớp PLC
    INSERT INTO MatchedData (plc_description, rfid_code, plc_timestamp, rfid_timestamp)
    SELECT 
        NULL AS plc_description,
        rfid.RFID AS rfid_code,
        NULL AS plc_timestamp,
        rfid.timestamp AS rfid_timestamp
    FROM 
        RFID rfid
    WHERE 
        NOT EXISTS (
            SELECT 1
            FROM PLC plc
            WHERE ABS(TIMESTAMPDIFF(SECOND, plc.timestamp, rfid.timestamp)) <= 5
        );
END