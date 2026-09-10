#!/bin/bash
set -e

# Detect package manager and install nginx
if command -v apt-get >/dev/null 2>&1; then
  # Ubuntu / Debian
  apt-get update -y
  apt-get install -y nginx
elif command -v yum >/dev/null 2>&1; then
  # Amazon Linux 2
  yum update -y
  amazon-linux-extras install nginx1 -y || yum install -y nginx
elif command -v dnf >/dev/null 2>&1; then
  # Amazon Linux 2023 / newer Fedora-based
  dnf install -y nginx
fi

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Create a simple identifying page
echo "<h1>Nginx is running on $(hostname)</h1>" > /var/www/html/index.html
echo "<p>Environment information written by user_data</p>" >> /var/www/html/index.html

# Optional: keep a log
echo "Nginx installed successfully on $(date)" >> /var/log/user-data.log