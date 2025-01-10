from flask import Flask, request, jsonify

app = Flask(__name__)

latest_sensor_value = None

@app.route('/', methods=['POST'])
def receive_data():
    global latest_sensor_value
    try:
        data = request.get_json()
        if 'sensorValue' in data:
            latest_sensor_value = data['sensorValue']
            print(f"Received sensor value: {latest_sensor_value}")
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

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
