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


# Decide background colour and friendly name
case "$ENV_NAME" in
  dev|development)
    BG_COLOR="#e3f2fd"      # light blue
    TITLE="Development"
    ;;
  qa|test)
    BG_COLOR="#fff3e0"      # light orange
    TITLE="QA / Test"
    ;;
  stg|staging|preprod)
    BG_COLOR="#f3e5f5"      # light purple
    TITLE="Staging / Pre-Prod"
    ;;
  prod|production)
    BG_COLOR="#e8f5e9"      # light green
    TITLE="Production"
    ;;
  *)
    BG_COLOR="#f5f5f5"      # light grey
    TITLE="$ENV_NAME"
    ;;
esac

HOSTNAME=$(hostname)
KERNEL=$(uname -a)
DATE=$(date)

# Create a nice HTML page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>$TITLE Environment</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: $BG_COLOR;
      margin: 40px;
    }
    h1 {
      color: #222;
      font-size: 2.2em;
    }
    .card {
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      max-width: 700px;
    }
    pre {
      background: #f0f0f0;
      padding: 12px;
      border-radius: 5px;
      overflow-x: auto;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>$TITLE Environment</h1>
    <p><strong>Hostname:</strong> $HOSTNAME</p>
    <p><strong>Environment:</strong> $ENV_NAME</p>
    <p><strong>Date:</strong> $DATE</p>
    <h3>System Information</h3>
    <pre>$KERNEL</pre>
    <p><em>Installed by Terraform user_data – Chandra Sharma</em></p>
  </div>
</body>
</html>
EOF

echo "Nginx page created for $ENV_NAME on $(date)" >> /var/log/user-data.log


# Create a simple identifying page
echo "<h1>Nginx is running on $(hostname)</h1>" > /var/www/html/index.html
echo "<p>Environment information written by user_data</p>" >> /var/www/html/index.html

# Optional: keep a log
echo "Nginx installed successfully on $(date)" >> /var/log/user-data.log