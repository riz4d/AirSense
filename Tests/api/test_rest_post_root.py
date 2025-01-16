import requests

BASE_URL = "http://127.0.0.1:80"

def test_post_root():
    response = requests.post(f"{BASE_URL}/", json={"sensorValue": 42})
    print(f"POST / response: {response.json()}")

if __name__ == "__main__":
    test_post_root()
