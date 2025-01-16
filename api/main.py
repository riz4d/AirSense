from flask import Flask, request, jsonify
from flask_socketio import SocketIO, emit

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")

latest_sensor_value = None
system_state_val = 0
normalairValue = 50

@app.route('/', methods=['POST'])
def receive_data():
    global latest_sensor_value
    try:
        data = request.get_json()
        if 'sensorValue' in data:
            latest_sensor_value = data['sensorValue']
            print(f"Received sensor value: {latest_sensor_value}")
            socketio.emit('sensor_update', {'sensorValue': latest_sensor_value})
            return jsonify({"status": "success", "receivedValue": latest_sensor_value}), 200
        else:
            return jsonify({"status": "error", "message": "Invalid payload"}), 400
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"status": "error", "message": "Invalid request"}), 400

@app.route('/gasdata', methods=['GET'])
def get_sensor_value():
    if latest_sensor_value is not None:
        return jsonify({"status": "success", "sensorValue": latest_sensor_value}), 200
    else:
        return jsonify({"status": "error", "message": "No data available"}), 404
@app.route('/system', methods=['POST'])
def system_state():
    global system_state_val
    try:
        data = request.get_json()
        print(data)
        if 'systemState' in data:
            system_state_val = data['systemState']
            print(f"Received System State: {system_state_val}")
            return jsonify({"status": "success", "receivedValue": system_state_val, "normalairValue": normalairValue}), 200
        else:
            return jsonify({"status": "error", "message": "Invalid payload"}), 400
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"status": "error", "message": "Invalid request"}), 400
@app.route('/state', methods=['GET'])
def get_state():
    if system_state_val is not None:
        return jsonify({"status": "success", "systemstate": system_state_val, "normalairValue":normalairValue}), 200
    else:
        return jsonify({"status": "error", "message": "No data available"}), 404
@app.route('/normalvalue', methods=['POST'])
def normal_val():
    global normalairValue
    try:
        data = request.get_json()
        print(data)
        if 'normalairValue' in data:
            normalairValue = data['normalairValue']
            print(f"Received System State: {normalairValue}")
            return jsonify({"status": "success", "receivedValue": normalairValue}), 200
        else:
            return jsonify({"status": "error", "message": "Invalid payload"}), 400
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"status": "error", "message": "Invalid request"}), 400

@app.route('/normalstate', methods=['GET'])
def get_nstate():
    if normalairValue is not None:
        return jsonify({"status": "success", "normalairValue": normalairValue}), 200
    else:
        return jsonify({"status": "error", "message": "No data available"}), 404
@socketio.on('connect')
def handle_connect():
    print("Client connected!")
    if latest_sensor_value is not None:
        emit('sensor_update', {'sensorValue': latest_sensor_value})

if __name__ == '__main__':
    socketio.run(app)
