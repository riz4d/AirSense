import requests

BASE_URL = "http://127.0.0.1:80"

def test_get_normalstate():
    response = requests.get(f"{BASE_URL}/normalstate")
    print(f"GET /normalstate response: {response.json()}")

if __name__ == "__main__":
    test_get_normalstate()
