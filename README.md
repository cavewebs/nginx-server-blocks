# nginx-server-blocks
This is a script that automates the creation of the Nginx server blocks and adds Lets encrypt to all the domains 

## How to use the script
simply call the script 

### Using CURL
`curl -o create_subdomains.sh https://github.com/cavewebs/nginx-server-blocks/blob/main/create_subdomains.sh && chmod +x create_subdomains.sh && ./create_subdomains.sh && rm create_subdomains.sh`
### Using WGET
`wget -O create_subdomains.sh https://github.com/cavewebs/nginx-server-blocks/blob/main/create_subdomains.sh && chmod +x create_subdomains.sh && ./create_subdomains.sh && rm create_subdomains.sh`

you will be prompted to enter how many subdomains you wont to create 

Next enter the name of the domains seperated by a comma (if more than 1)

at the end, you will be asked if you want to create SSL certifcates for them, if you choose yes, the certificates will be created using Letsencrypt/certbot

at the end, the script will be deleted from your server.

Thats all. 
Please give a star if you found this useful
If you found a bug or have a wishlist, open and issue.
Improvements are welcome too

## Buy me coffee
If you would like to please [buy me a coffee](https://www.buymeacoffee.com/timchosen)
