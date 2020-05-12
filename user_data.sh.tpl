#!/bin/bash
apt update -y
apt install -y ${app0} ${app1}
echo "Web server started." > /var/www/html/index.html
systemctl start ${app0}
systemctl enable ${app0}

