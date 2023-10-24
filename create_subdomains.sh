#!/bin/bash

# Prompt the user for the number of subdomains
read -p "How many subdomains do you want to create? " num_subdomains

# Initialize an array to store the subdomains
subdomains=()

# Prompt the user for each subdomain
for ((i=1; i<=$num_subdomains; i++)); do
    read -p "Enter subdomain $i: " subdomain
    subdomains+=("$subdomain")
done

# Create subdomains and Nginx server blocks
for subdomain in "${subdomains[@]}"; do
    # Create directories and set permissions
    sudo mkdir /var/www/$subdomain
    sudo mkdir /var/www/$subdomain/html
    sudo chown -R $USER:$USER /var/www/$subdomain

    # Create an Nginx server block
    sudo tee /etc/nginx/sites-available/$subdomain >/dev/null <<EOF
server {
    listen 80;
    listen [::]:80;

    root /var/www/$subdomain/html;
    index index.html index.htm index.nginx-debian.html;

    server_name $subdomain;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

    # Create a symbolic link to enable the site
    sudo ln -s /etc/nginx/sites-available/$subdomain /etc/nginx/sites-enabled/
done

# Reload Nginx to apply the changes
sudo systemctl reload nginx

# Prompt the user if they want to set up Let's Encrypt
read -p "Do you want to set up Let's Encrypt for all domains? (yes/no): " setup_certbot

if [ "$setup_certbot" = "yes" ]; then
    # Install Certbot and obtain SSL certificates
    sudo apt install certbot python3-certbot-nginx

    for subdomain in "${subdomains[@]}"; do
        sudo certbot --nginx -d $subdomain
    done

    # Optionally, renew certificates
    sudo systemctl enable certbot.timer
    sudo systemctl start certbot.timer
else
    echo "Certbot setup skipped."
fi

echo "Subdomains and Nginx server blocks have been created."
