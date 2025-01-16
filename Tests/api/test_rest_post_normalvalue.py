import requests

BASE_URL = "http://127.0.0.1:80"

def test_post_normalvalue():
    response = requests.post(f"{BASE_URL}/normalvalue", json={"normalairValue": 50})
    print(f"POST /normalvalue response: {response.json()}")

if __name__ == "__main__":
    test_post_normalvalue()
