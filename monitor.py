import time
import subprocess
import requests

# The URL of our 'Gold Path' app
APP_URL = "http://localhost:9000"

def heal():
    print("🚑 HEALER: App is down! Triggering Terraform repair...")
    # This is the 'Self-Healing' magic: running Terraform automatically
    subprocess.run(["terraform", "apply", "-auto-approve"])

def check_health():
    try:
        response = requests.get(APP_URL, timeout=5)
        if response.status_code == 200:
            print("✅ MONITOR: App is healthy.")
            return True
        else:
            print(f"⚠️ MONITOR: App returned status {response.status_code}")
            return False
    except Exception:
        return False

print("🚀 AEGIS MONITOR STARTING...")
while True:
    if not check_health():
        heal()
    # Wait 10 seconds before checking again
    time.sleep(10)