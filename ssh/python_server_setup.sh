#!/bin/bash

USERNAME=$(whoami)
GROUP_NAME=$(id -gn)

sudo mkdir -p /usr/bin/pysch

# python exec file creation
python_file()
{
    cat << EOF >/usr/bin/pysch/psych_py.py
import http.server
import socketserver

PORT = 8080
handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("",PORT), handler) as httpd:
    print(f"Server at Port {PORT}")
    httpd.serve_forever()
EOF
}

# creating a service file

service_file()
{
    cat << EOF | sudo tee /etc/systemd/system/httpserver.service > /dev/null
[UNIT]
Description=Python Http Server
After=network.target

[Service]
ExecStart=/usr/bin/python3 /usr/bin/pysch/psych_py.py
WorkingDirectory=/home/$USERNAME
Restart=always
User=$USERNAME
Group=$GROUP_NAME

[Install]
WantedBy=multi-user.target
EOF
}

# checks if /usr/bin exist or not
if [ ! -d /usr/bin ]; then
    echo "[X] Directory /usr/bin does not exist. Please check your system"
    exit 1
fi

# code exec command
exec()
{
    python_file
    service_file

    sudo systemctl daemon-reload
    sudo systemctl enable httpserver.service
    sudo systemctl start httpserver.service
    sudo systemctl status httpserver.service
    sudo journalctl -u httpserver.service

}

exec
