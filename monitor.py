import requests
import subprocess
import time

# Configuration
URL = "http://localhost:9000"
CHECK_INTERVAL = 10  # seconds
RESOURCE_TARGET = "docker_container.aegis_link_test"

def check_health():
    try:
        response = requests.get(URL, timeout=5)
        if response.status_code == 200:
            print(f"[{time.strftime('%H:%M:%S')}] Aegis is Healthy (200 OK)")
            return True
        else:
            print(f"[{time.strftime('%H:%M:%S')}] Health Check Failed: {response.status_code}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"[{time.strftime('%H:%M:%S')}] Aegis is DOWN: {e}")
        return False

def trigger_rebuild():
    print(f"[{time.strftime('%H:%M:%S')}] 🚨 TRIGGERING SELF-HEALING REBUILD...")
    try:
        # Executes the terraform replace command we used in the GitHub Action
        subprocess.run(
            ["terraform", "apply", f"-replace={RESOURCE_TARGET}", "-auto-approve"],
            check=True
        )
        print(f"[{time.strftime('%H:%M:%S')}] ✅ Rebuild Complete. Waiting for stabilization...")
        time.sleep(5)
    except subprocess.CalledProcessError as e:
        print(f"[{time.strftime('%H:%M:%S')}] ❌ Rebuild Failed: {e}")

def main():
    print(f"Starting Aegis Monitor for {URL}...")
    while True:
        if not check_health():
            trigger_rebuild()
        time.sleep(CHECK_INTERVAL)

if __name__ == "__main__":
    main()