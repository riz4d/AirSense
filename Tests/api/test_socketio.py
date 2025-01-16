from socketio import Client

SOCKET_URL = "http://127.0.0.1:80"
socketio_client = Client()

def test_socketio():
    @socketio_client.on('connect')
    def on_connect():
        print("Connected to SocketIO server.")

    @socketio_client.on('sensor_update')
    def on_sensor_update(data):
        print(f"Received sensor update: {data}")
        socketio_client.disconnect()

    @socketio_client.on('disconnect')
    def on_disconnect():
        print("Disconnected from SocketIO server.")

    try:
        socketio_client.connect(SOCKET_URL)
        socketio_client.wait()
    except Exception as e:
        print(f"SocketIO test failed: {e}")

if __name__ == "__main__":
    test_socketio()
