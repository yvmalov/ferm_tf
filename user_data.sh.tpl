#!/bin/bash
apt update -y
apt install -y ${app0}
echo "Web server completed." > /var/www/html/index.html
systemctl start ${app0}
systemctl enable ${app0}

