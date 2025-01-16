import requests

BASE_URL = "http://127.0.0.1:80"

def test_post_system():
    response = requests.post(f"{BASE_URL}/system", json={"systemState": "ON"})
    print(f"POST /system response: {response.json()}")

if __name__ == "__main__":
    test_post_system()
