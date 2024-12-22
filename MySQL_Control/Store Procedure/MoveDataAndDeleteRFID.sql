CREATE DEFINER=`sql12746806`@`%` PROCEDURE `MoveDataAndDeleteRFID`(IN input_rfid VARCHAR(50), IN output_time TIMESTAMP)
BEGIN
    DECLARE matched_count INT;

    -- Kiểm tra xem mã RFID có tồn tại trong bảng MatchedAll không
    SELECT COUNT(*) INTO matched_count
    FROM MatchedAll
    WHERE rfid_code = input_rfid;

    IF matched_count > 0 THEN
        -- Chuyển dữ liệu từ bảng MatchedAll sang bảng out_put
        INSERT INTO out_put (rfid_code, rfid_timestamp, plc_description, plc_timestamp, store_info, store_timestamp, output_timestamp)
        SELECT rfid_code, rfid_timestamp, plc_description, plc_timestamp, store_info, store_timestamp, output_time
        FROM MatchedAll
        WHERE rfid_code = input_rfid;

        -- Xóa dữ liệu từ bảng MatchedAll
        DELETE FROM MatchedAll
        WHERE rfid_code = input_rfid;

        -- Gọi Stored Procedure DeleteDataByRFID để xóa dữ liệu trong các bảng RFID, PLC, store
        CALL DeleteDataByRFID(input_rfid);
    ELSE
        -- Trường hợp không tìm thấy mã RFID trong bảng MatchedAll
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã RFID không tồn tại trong bảng MatchedAll.';
    END IF;
END