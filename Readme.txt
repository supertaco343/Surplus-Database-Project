This readme is mainly here to help you start the database server.  
This was developed and tested on Fedora 40 Linux, but should work on any other linux version.  To get it to launch on Windows, you may need to download the SQLPage Windows version and move the pages (everything that has a .sql file extension on it) and the migrations folder to the downloaded folder.  This readme will go based off of a Linux install.  
To launch: 1. Open/navigate to the folder in terminal.
2. Start the database with the command "./sqlpage.bin".  
2.1. If it says "access denied" when running the previous command, then you may need to add the executable flag to the file by running the command "chmod +x ./sqlpage.bin".  After doing so, rerun the command in 2.
3. The server should be running now, and accessible in a browser now.  To access it on the machine it is running on, go to "localhost:8080"
3.1. If you wish to access the server on another machine, it should already be open, but you must find the IP address of the machine you are using.  If you are going to access it on the same network, then run the command "ip a" in a different terminal, and find the ip address under "wlp3s0", and should be of the form "xxx.xxx.xxx.xxx", where x can be blank or a number.  Type this ip address into your other machine wiht the addition of ":8080" to the end of it, and it should take you to the server.  If you are accessing it NOT on the same network, you can google your IP address, and entering that IP with the addition of ":8080" should take you to the server.  
4. Enjoy the website.  
