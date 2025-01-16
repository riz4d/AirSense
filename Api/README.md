# AirSense API 

Flask-based API for handling and managing sensor data. It supports real-time communication using Socket.IO and includes endpoints for posting and retrieving sensor values, system states, and normal air values.


## Features

- **Sensor Data Handling**: Accepts and stores sensor values via API.
- **Real-Time Updates**: Broadcasts sensor value updates to connected clients using Socket.IO.
- **System State Management**: Manages and retrieves system state data.
- **Normal Air Value Configuration**: Allows setting and retrieving the normal air value.
- **Simple Setup**: Easily configurable via constants and system files.

## Installation

### Prerequisites
- Python 3.8 or later
- Flask and Flask-SocketIO libraries

### Setup Steps

1. Clone the repository:
    ```bash
    git clone https://github.com/riz4d/AirSense
    cd AirSense/Api
    ```

2. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

3. Run the application:
    ```bash
    python main.py
    ```
    The server will start on http://0.0.0.0:80 by default.

## API Endpoints

### 1. Receive Sensor Data
- **Endpoint**: `/`
- **Method**: `POST`
- **Payload**:
    ```json
    {
        "sensorValue": <integer>
    }
    ```
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "receivedValue": <sensorValue>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "Invalid payload"
        }
        ```

### 2. Get Latest Sensor Data
- **Endpoint**: `/gasdata`
- **Method**: `GET`
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "sensorValue": <latest_sensor_value>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "No data available"
        }
        ```

### 3. Set System State
- **Endpoint**: `/system`
- **Method**: `POST`
- **Payload**:
    ```json
    {
        "systemState": <integer>
    }
    ```
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "receivedValue": <systemState>,
            "normalairValue": <normalairValue>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "Invalid payload"
        }
        ```

### 4. Get System State
- **Endpoint**: `/state`
- **Method**: `GET`
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "systemstate": <system_state_val>,
            "normalairValue": <normalairValue>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "No data available"
        }
        ```

### 5. Set Normal Air Value
- **Endpoint**: `/normalvalue`
- **Method**: `POST`
- **Payload**:
    ```json
    {
        "normalairValue": <integer>
    }
    ```
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "receivedValue": <normalairValue>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "Invalid payload"
        }
        ```

### 6. Get Normal Air Value
- **Endpoint**: `/normalstate`
- **Method**: `GET`
- **Response**:
    - **Success**:
        ```json
        {
            "status": "success",
            "normalairValue": <normalairValue>
        }
        ```
    - **Error**:
        ```json
        {
            "status": "error",
            "message": "No data available"
        }
        ```

## Socket.IO Events

### Connect
Triggered when a client connects. Sends the latest sensor value to the client.

### Sensor Update
Broadcasted when a new sensor value is received.
- **Payload**:
    ```json
    {
        "sensorValue": <latest_sensor_value>
    }
    ```

## Project Structure

```plaintext
├── Api
│   ├── main.py           # Main Flask application
│   ├── constants.py      # Stores global constants for sensor and state values
│   ├── system.py         # Configuration for host, port, and debug mode
│   ├── requirements.txt  # Project dependencies
│   ├── vercel.json       # Vercel deployment configuration
```
### License

This project is licensed under [MIT License](LICENSE).
