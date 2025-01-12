#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClientSecure.h>
#include <ArduinoJson.h>

int lcdColumns = 16;
int lcdRows = 2;
LiquidCrystal_I2C lcd(0x27, lcdColumns, lcdRows);
#define Red D5
#define Green D6
#define Buzzer D7
#define Sensor A0
/home/riza/Downloads/arduino-ide_2.3.4_Linux_64bit.AppImage
const char* ssid = "Airsense";
const char* password = "1234567890";
const char* apiUrl = "https://air-sense-api.vercel.app/";
const char* stateUrl = "https://air-sense-api.vercel.app/state";

bool systemOn = false;

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
  delay(1000);
  lcd.clear();
}

void fetchSystemState() {
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClientSecure client;
    client.setInsecure();

    HTTPClient http;
    http.begin(client, stateUrl);
    int httpCode = http.GET();
    if (httpCode > 0) {
      String response = http.getString();
      Serial.println("State response: " + response);

      StaticJsonDocument<200> doc;
      DeserializationError error = deserializeJson(doc, response);
      if (!error) {
        const char* status = doc["status"];
        int state = doc["systemstate"];

        if (String(status) == "success") {
          systemOn = (state == 1);
        }
      } else {
        Serial.print("JSON Parsing Error: ");
        Serial.println(error.c_str());
      }
    } else {
      Serial.println("Failed to fetch system state.");
    }
    http.end();
  } else {
    Serial.println("WiFi not connected.");
  }
}

void checkGasLevel() {
  int sensor = analogRead(Sensor);
  Serial.println(sensor);
  sensor = map(sensor, 0, 1024, 0, 100);
  
  if (sensor <= 50) {
    digitalWrite(Green, HIGH);
    digitalWrite(Red, LOW);
    digitalWrite(Buzzer, LOW); // No buzzer for normal values
    lcd.setCursor(0, 1);
    lcd.print("Gas value:Normal");
  } else if (sensor > 50) {
    digitalWrite(Green, LOW);
    digitalWrite(Red, HIGH);
    digitalWrite(Buzzer, HIGH); // Buzzer on for high values
    lcd.setCursor(0, 1);
    lcd.print("Gas value:High");
  }
  lcd.setCursor(0, 0);
  lcd.print("Value : ");
  lcd.print(sensor);

  // Send data to the server
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClientSecure client;
    client.setInsecure();

    HTTPClient http;
    http.begin(client, apiUrl);
    http.addHeader("Content-Type", "application/json");
    String payload = "{\"sensorValue\":" + String(sensor) + "}";
    int httpCode = http.POST(payload);
    Serial.println(httpCode);
    if (httpCode > 0) {
      Serial.println("Data sent successfully!");
      Serial.println("Response: " + http.getString());
    } else {
      Serial.println("Failed to send data.");
    }

    http.end();
  } else {
    Serial.println("WiFi not connected.");
  }
}

void idleMode() {
  digitalWrite(Green, LOW);
  digitalWrite(Red, LOW);
  digitalWrite(Buzzer, LOW);
  lcd.setCursor(0, 0);
  lcd.print("System is OFF  ");
  lcd.setCursor(0, 1);
  lcd.print("Idle Mode Active");
}

void loop() {
  fetchSystemState();
  if (systemOn) {
    lcd.clear();
    checkGasLevel();
  } else {
    lcd.clear();
    idleMode();
  }
  delay(1000);
}
