# Air Sense

**AirSense** is a comprehensive air quality monitoring solution that consists of hardware sensors, a mobile application, and a powerful API backend. It allows users to monitor gas levels, control the system, and analyze data in real time, ensuring the safety and efficiency of the monitored environment.


## How It Works

### Data Collection
The ESP8266 reads gas levels from the sensor and sends them to the Flask API at regular intervals.

### Mobile App Monitoring
The mobile application fetches real-time gas data and updates the gauge meter accordingly.

### System Control
Users can adjust the normal gas value threshold and turn the system on or off via the mobile app.

### Data Logging & Analytics
The application stores sensor logs and displays them in real-time, allowing users to monitor the trends.

## Project Overview

- **Hardware**: The system utilizes IoT sensors connected to an ESP8266 board to monitor gas levels and communicate with the server.
- **Mobile Application**: The Flutter-based mobile application provides a user-friendly interface to interact with the system, visualize sensor data, and control system settings.
- **API**: The backend API built with Flask handles data from the sensors, system controls, and analytics.

---

## Project Structure

The project is divided into several components:
- **Hardware**: Contains code for the ESP8266 and sensor integration.
- **Mobile Application**: Flutter-based app for monitoring, control, and analytics.
- **API**: Flask-based backend for receiving sensor data, processing system state, and providing analytics.

## Hardware Setup

The **hardware** component is based on an ESP8266 microcontroller that reads gas levels from an analog sensor (MQ sensor or similar). It uses **I2C** communication for the LCD display and WiFi to send data to the backend API.

### Components Required:
- ESP8266 board (e.g., NodeMCU)
- Gas sensor (e.g., MQ-2)
- LCD with I2C interface
- Jumper wires
- Breadboard (optional)
- Power source (5V USB adapter)

### Hardware Wiring:
- Connect the gas sensor to the **A0** pin of the ESP8266.
- Connect the LCD to the ESP8266 via I2C (usually **SDA** and **SCL** pins).
- Wire the **Red, Green, and Buzzer** pins for status indication.

> **Refer to the `Hardware/README.md`** for detailed setup and wiring instructions.

---

## API (Backend)

The **API** handles all communication between the hardware sensors and the mobile application. It is built using **Flask** and **Socket.IO** for real-time communication.

### Key Features:
- **Data Reception**: Receives sensor data from the ESP8266 device and updates the system.
- **System Control**: Allows users to send system states (on/off) and adjust the normal air value (threshold for gas detection).
- **Real-Time Updates**: Pushes real-time sensor updates to connected clients via **Socket.IO**.

### Endpoints:
- `POST /` - Receives gas sensor data from the hardware.
- `GET /gasdata` - Fetches the latest gas sensor data.
- `POST /system` - Sets the system state (on/off).
- `POST /normalvalue` - Sets the normal air threshold value.
- `GET /state` - Retrieves the current system state.
- `GET /normalstate` - Retrieves the current normal air value.

### Running the API Locally:
1. Navigate to the `api/` directory.
2. Install the dependencies:
    ```bash
    pip install -r requirements.txt
    ```
3. Start the Flask server:
    ```bash
    python app.py
    ```
> **Refer to the `Api/README.md`** for detailed setup and instructions.

## Mobile Application

The mobile application is developed using Flutter and provides an easy-to-use interface to monitor and control the system remotely.

### Features:
- **Gauge Meter**: Displays real-time gas levels using a gauge meter.
- **System Controls**: Toggle button to turn the system on/off and set the normal value.
- **Real-Time Analytics**: View gas levels over time with graphs and logs.
- **Sensor Logs**: View historical data from the sensors.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Acknowledgments

- **Flutter**: For building the cross-platform mobile application.
- **ESP8266**: For providing an affordable and reliable IoT solution for gas monitoring.
- **Flask**: For creating the backend API.
