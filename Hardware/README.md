# AirSense Hardware

IoT-based gas monitoring system designed to detect and report gas levels in real time. The system uses an ESP8266 microcontroller, an MQ gas sensor, and an LCD display to monitor air quality and alert users about abnormal gas levels. The device connects to a remote API for data synchronization and system state updates.

## Features

- Real-time monitoring of gas levels.
- Visual and audible alerts using LEDs, a buzzer, and an LCD display.
- Remote system control and state management via an API.
- Wi-Fi connectivity for seamless data transmission.
- Dynamic threshold adjustment for normal gas levels.

## How It Works

1. On startup, the ESP8266 connects to the specified Wi-Fi network.
2. The system fetches the current operational state (`systemOn`) and normal air value (`normalAirValue`) from the API.
3. If the system is ON, it reads the gas sensor values and:
    - Turns on the green LED if the gas level is normal.
    - Turns on the red LED and buzzer if the gas level exceeds the normal value.
4. The gas level is displayed on the LCD, and the data is sent to the API.
5. If the system is OFF, the device enters idle mode, turning off all LEDs and the buzzer.

## Components Used

1. **Hardware:**
    - ESP8266 NodeMCU
    - MQ-135 or MQ-137 Gas Sensor
    - 16x2 I2C LCD Display
    - LEDs (Red, Green)
    - Buzzer
    - Resistors and connecting wires

2. **Software:**
    - Arduino IDE
    - Required libraries:
      - LiquidCrystal_I2C
      - ESP8266WiFi
      - ESP8266HTTPClient
      - WiFiClientSecure
      - ArduinoJson

## API Endpoints

The system interacts with the following endpoints:

1. **System State Endpoint**: `https://air-sense-api.vercel.app/state`
    - **Method**: `GET`
    - **Response**:
    
        ```json
        {
            "status": "success",
            "systemstate": 1,
            "normalairValue": 50.0
        }
        ```

2. **Sensor Data Endpoint**: `https://air-sense-api.vercel.app/`
    - **Method**: `POST`
    - **Payload**:
        ```json
        {
            "sensorValue": 42
        }
        ```

## Installation and Setup

1. **Hardware Setup**:
    - Connect the gas sensor to the analog input pin of the ESP8266.
    - Attach the LCD display via the I2C interface.
    - Connect the LEDs and buzzer to digital pins as specified in the code.

2. **Software Setup**:
    - Install the required libraries in the Arduino IDE:
        - `LiquidCrystal_I2C`
        - `ESP8266WiFi`
        - `ESP8266HTTPClient`
        - `WiFiClientSecure`
        - `ArduinoJson`
    - Upload the code to the ESP8266 using the Arduino IDE.

3. **Wi-Fi Configuration**:
    - Set the Wi-Fi SSID and password in the following section of the code:
        ```cpp
        const char* ssid = "Airsense";
        const char* password = "1234567890";
        ```

4. **API Configuration**:
    - Update the API URLs if needed:
        ```cpp
        const char* apiUrl = "https://air-sense-api.vercel.app/";
        const char* stateUrl = "https://air-sense-api.vercel.app/state";
              ```

## Functions Overview

1. **`fetchSystemState()`**:
    - Fetches the current system state and normal air value from the API.
    - Updates the global variables `systemOn` and `normalAirValue`.

2. **`checkGasLevel()`**:
    - Reads the gas sensor value.
    - Compares it against `normalAirValue` and triggers alerts if necessary.
    - Sends the gas level data to the API.

3. **`idleMode()`**:
    - Disables all indicators and sets the system to idle mode.

4. **`loop()`**:
    - Continuously fetches the system state and checks gas levels if the system is ON.

## Visual Indicators

| Component  | Status       | Action                               |
|------------|--------------|--------------------------------------|
| Green LED  | ON           | Gas level is normal.                |
| Red LED    | ON           | Gas level is high.                  |
| Buzzer     | ON           | Gas level is high.                  |
| LCD        | Gas level    | Displays gas level and system state.|

## Troubleshooting

1. **Wi-Fi Connection Issues**:
    - Ensure the correct SSID and password are set in the code.
    - Check if the Wi-Fi network is operational and within range.

2. **Sensor Malfunction**:
    - Verify the connections between the gas sensor and the ESP8266.
    - Ensure the sensor is powered correctly and not damaged.

3. **API Communication Problems**:
    - Check if the API endpoints are accessible and the URLs are correct.
    - Verify the device has internet access.

4. **Display Issues**:
    - Ensure the I2C address of the LCD is correctly set in the code.
    - Check the connections between the LCD and the ESP8266.

5. **Alert System Not Working**:
    - Verify the connections of the LEDs and buzzer.
    - Ensure the correct pins are defined in the code.

## Acknowledgments

- Inspired by IoT projects in air quality monitoring.
- Thanks to the open-source community for providing essential libraries.

### License

This project is licensed under [MIT License](LICENSE).
