CREATE DEFINER=`sql12746806`@`%` PROCEDURE `DeleteDataByRFID`(IN input_rfid VARCHAR(50))
BEGIN
    DECLARE rfid_timestamp TIMESTAMP;

	IF NOT EXISTS (
			SELECT 1
			FROM sql12746806.RFID
			WHERE RFID = input_rfid
		) 
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'RFID không tồn tại trong bảng.';
    ELSE
    -- Lấy timestamp của hàng trong bảng RFID theo mã RFID nhập vào
    SELECT `timestamp` INTO rfid_timestamp
    FROM sql12746806.RFID
    WHERE RFID = input_rfid;

    -- Xóa hàng trong bảng RFID nếu tồn tại mã RFID
    DELETE FROM sql12746806.RFID
    WHERE RFID = input_rfid;

    -- Xóa dữ liệu trong bảng PLC nếu timestamp < 5s so với rfid_timestamp
    DELETE FROM sql12746806.PLC
    WHERE ABS(TIMESTAMPDIFF(SECOND, `timestamp`, rfid_timestamp)) < 5;

    -- Xóa dữ liệu trong bảng store với điều kiện cụ thể cho từng kho
    DELETE FROM sql12746806.store
    WHERE (store = 'Kho 2' AND ABS(TIMESTAMPDIFF(SECOND, `timestamp`, rfid_timestamp)) < 10)
       OR (store = 'Kho 4' AND ABS(TIMESTAMPDIFF(SECOND, `timestamp`, rfid_timestamp)) < 15)
       OR (store = 'Kho 9.1' AND ABS(TIMESTAMPDIFF(SECOND, `timestamp`, rfid_timestamp)) < 23)
       OR (store = 'Kho 9.2' AND ABS(TIMESTAMPDIFF(SECOND, `timestamp`, rfid_timestamp)) < 25);
END IF;
END