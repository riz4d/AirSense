#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

int lcdColumns = 16;
int lcdRows = 2;

LiquidCrystal_I2C lcd(0x27, lcdColumns, lcdRows);
#define Buzzer D5
#define Green D6
#define Red D7
#define Sensor A0

const char* ssid = "BlackHat";
const char* password = "123456789";
const char* apiUrl = "http://192.168.43.152:80";

void setup() {
  Serial.begin(9600);
  lcd.init();
  lcd.backlight();

  pinMode(Green, OUTPUT);
  pinMode(Red, OUTPUT);
  pinMode(Buzzer, OUTPUT);
  pinMode(Sensor, INPUT);

  WiFi.begin(ssid, password);
  lcd.setCursor(0, 0);
  lcd.print("Connecting...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  lcd.clear();
  lcd.print("WiFi Connected!");
  delay(2000);
  lcd.clear();
}

void checkGasLevel() {
  int sensor = analogRead(Sensor);
  Serial.println(sensor);
  sensor = map(sensor, 0, 1024, 0, 100);
  if (sensor <= 50) {
    digitalWrite(Green, HIGH);
    digitalWrite(Red, LOW);
    digitalWrite(Buzzer, LOW);
    lcd.setCursor(0, 1);
    lcd.print("Gas value:Normal");
  } else {
    digitalWrite(Green, LOW);
    digitalWrite(Red, HIGH);
    digitalWrite(Buzzer, HIGH);
    lcd.setCursor(0, 1);
    lcd.print("Gas value:High  ");
  }
  lcd.setCursor(0, 0);
  lcd.print("Value : ");
  lcd.print(sensor);

  if (WiFi.status() == WL_CONNECTED) {
    WiFiClient client;
    HTTPClient http;

    http.begin(client, apiUrl);
    http.addHeader("Content-Type", "application/json");
    String payload = "{\"sensorValue\":" + String(sensor) + "}";
    int httpCode = http.POST(payload);

    if (httpCode > 0) {
      Serial.println("Data sent successfully!");
      Serial.println("Response: " + http.getString());
    } else {
      Serial.println("Response: " + http.getString());
      Serial.println("Failed to send data.");
    }

    http.end();
  } else {
    Serial.println("WiFi not connected.");
  }
}

void loop() {
  checkGasLevel();
  delay(1000);
}
