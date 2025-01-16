# AirSense Mobile Application

The **AirSense Mobile Application** is a companion app for the AirSense IoT Gas Monitoring System. It provides real-time monitoring, system controls, and analytics to help ensure air quality and system performance.

## Features

### 1. **Gauge Meter for Gas Levels**
- Displays real-time gas levels using an intuitive gauge meter.
- Allows users to monitor air quality at a glance.

### 2. **System Controls**
- **Turn System On/Off**: Control the monitoring system remotely with a toggle button.
- **Set Normal Value**: Adjust the threshold for normal gas levels dynamically from the app.

### 3. **Sensor Logs**
- Stores and displays logs of sensor data in real time.
- Provides easy access to historical gas level data.

### 4. **Real-Time Analytics**
- Visualizes gas levels over time with charts and graphs.
- Offers insights into air quality trends and system performance.

### 5. **Secure Communication**
- Communicates with the AirSense API using HTTPS.
- Ensures data privacy and reliability.

## Usage

### Gauge Meter
- View real-time gas levels using an intuitive gauge interface.
- The meter updates automatically as sensor values change.

### System Controls
- Use the toggle button to enable or disable the system.
- Adjust the normal air value via the slider.

### Analytics
- Access the "Analytics" tab to view graphical trends and real-time data logs.

### Logs
- Check detailed logs of gas sensor data for historical reference.

## Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or Xcode for device emulation and debugging.

### Steps
1. Clone this repository:
    ```bash
    git clone https://github.com/riz4d/AirSense
    ```
2. Navigate to the application directory:
    ```bash
    cd AirSense/Application
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app:
    ```bash
    flutter run
    ```

## Acknowledgments

Thanks to the Flutter community for their amazing libraries and support.
Inspired by modern IoT applications for air quality monitoring.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.