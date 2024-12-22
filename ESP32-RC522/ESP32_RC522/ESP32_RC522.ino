#include <WiFi.h>
#include <ESP32_MySQL.h>
#include <SPI.h>
#include <MFRC522.h>
#include <time.h>  // Thư viện time.h cho việc đồng bộ thời gian

// Thông tin kết nối Wi-Fi
char ssid[] = "APS Lab";             // Wi-Fi SSID
char pass[] = "Vim#0343222666";        // Wi-Fi Password

// Thông tin kết nối MySQL
char user[] = "sql12746806";       // Tên đăng nhập MySQL
char password[] = "7zIqWUVnEV";    // Mật khẩu MySQL
char database[] = "sql12746806";   // Tên database
char table[] = "RFID";             // Tên bảng

// Cấu hình RFID
#define RST_PIN 22 // Chân RST kết nối với D22
#define SS_PIN 5   // Chân SDA kết nối với D5
MFRC522 mfrc522(SS_PIN, RST_PIN);

#define USING_HOST_NAME false
IPAddress server(52, 76, 27, 242); // Địa chỉ MySQL server

uint16_t server_port = 3306;       // Cổng MySQL (mặc định là 3306)

// Tạo kết nối MySQL
ESP32_MySQL_Connection conn((Client *)&client); // Sử dụng `client` của thư viện
unsigned long last_UID = 0; // Lưu UID đọc trước đó

void setup() {
    Serial.begin(9600);
    while (!Serial && millis() < 5000); // Chờ kết nối Serial

    // Khởi tạo RFID
    SPI.begin(18, 19, 23); // SCK=D18, MISO=D19, MOSI=D23
    mfrc522.PCD_Init();

    // Kết nối Wi-Fi
    Serial.print(".");
    WiFi.begin(ssid, pass);
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nKết nối Wi-Fi thành công!");
    Serial.print("Địa chỉ IP: ");
    Serial.println(WiFi.localIP());

    // Đồng bộ thời gian qua NTP
    configTime(7 * 3600, 0, "pool.ntp.org");  // Múi giờ Việt Nam là GMT+7 (7*3600 giây)
    Serial.println("Đang đồng bộ thời gian với NTP...");
    while (!time(nullptr)) {  // Kiểm tra nếu thời gian chưa được đồng bộ
        delay(1000);
        Serial.print(".");
    }
    Serial.println("\nĐồng bộ thời gian thành công!");
}

String getTimestamp() {
    struct tm timeinfo;
    if (!getLocalTime(&timeinfo)) {
        Serial.println("Lỗi lấy thời gian!");
        return "";
    }

    char buffer[20];
    strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", &timeinfo); // Định dạng theo MySQL
    return String(buffer);
}

void insertToDatabase(const char* uid) {
    if (conn.connect(server, server_port, user, password)) {
        // Lấy timestamp hiện tại
        String timestamp = getTimestamp();

        // Tạo câu lệnh INSERT
        String sql = String("INSERT INTO ") + database + "." + table + 
                     " (RFID, timestamp) VALUES ('" + uid + "', '" + timestamp + "')";

        // Thực thi câu lệnh
        ESP32_MySQL_Query query_mem(&conn);
        if (query_mem.execute(sql.c_str())) {
            Serial.println("Dữ liệu đã được chèn vào database.");
        } else {
            Serial.println("Lỗi khi chèn dữ liệu.");
        }

        // Đóng kết nối
        conn.close();
    } else {
        Serial.println("Kết nối MySQL thất bại!");
    }
}

void loop() {
    // Kiểm tra nếu có thẻ RFID mới
    if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
        return;
    }

    // Đọc UID
    unsigned long UID_dec = 0;
    for (byte i = mfrc522.uid.size; i > 0; i--) {
        UID_dec = (UID_dec << 8) | mfrc522.uid.uidByte[i - 1];
    }

    // Chuyển UID thành chuỗi
    char UID_str[11];
    sprintf(UID_str, "%010lu", UID_dec);

    // Gửi UID lên MySQL nếu khác với UID trước đó
    if (UID_dec != last_UID) {
        Serial.print("Đọc được UID: ");
        Serial.println(UID_str);

        insertToDatabase(UID_str); // Gửi UID lên database

        last_UID = UID_dec; // Lưu lại UID vừa đọc
    }

    // Kết thúc giao tiếp với thẻ
    mfrc522.PICC_HaltA();
    mfrc522.PCD_StopCrypto1();
}
