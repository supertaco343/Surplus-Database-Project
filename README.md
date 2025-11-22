# Surplus-Database-Project

## Project Description
This is a self hosted database service with a web GUI made for Surplus, but could be modified for other businesses.  Built using SQLPage.

## Features
- Full CRUD database implementation (the ability to create users/items, search items by keywords, change user permissions/item descriptions, and remove items/users) inside web GUI
- Web GUI able to be hosted and served on a small/low power computer (tested on a i3-6100 inside a Dell AIO computer)
- Can be used only for internal use, or opened up to customers to view on their own devices
- User login with different permissions (ie, admins, editors, and customers)
- User creation and verification
- For use on Windows and Linux (this repo assumes you are using Linux)

## Tech Stack
**Backend** SQLPage, SQLite  
**Frontend** SQLPage  
**Database** SQLite  
**Deployment** Self-hosted on small machine  

## Installation and Setup
1. Clone the repo:
```
git clone https://github.com/supertaco343/Surplus-Database-Project.git
cd Surplus-Database-Project
```
2. Unzip the .bin file:

Use your own file decompressor/unzip on the "sqlpage.zip" file, and then place the "sqlpage.bin" file into the root directory of the project (where index.sql is located with many other files)  

3. Start the database:
```
./sqlpage.bin
```
If it gives the error "Access Denied", run the command below, then try to start the database again with the above command
```
chmod +x ./sqlpage.bin
```
4. Access the web GUI and some initial setup:

Open up your browser of choice, and go to "localhost:8080".  You should be sent to the initial page for the database.  
The initial database is given 3 users, with matching usernames and passwords as "admin", "editor", and "user".  You should add your own admin user in the registration page, and then approve them under the "admin" user, then remove the default "admin" user for security.  The other 2 users should also be replaced and removed, but not as important.

5. Use on another machine (optional):

If you want to access the database on a different device from the one it is hosted on, it initially should be open to outside connections, but you will need to find your IP address of the machine it is hosted on.
If you are accessing it from the same network, you can run the command below, and find the local IP address of the host machine
```
ip a
```
Find the ip address under "wlp3s0", and should be of the form "xxx.xxx.xxx.xxx", where x can be blank or a number.  Type this ip address into your other machine with the addition of ":8080" to the end of it, and it should take you to the server.  
If you are accessing it from a different network, you can google your IP address on the host machine, and then type that address with the addition of ":8080" again, and it should take you to the server.  
