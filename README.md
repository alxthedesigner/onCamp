# onCamp
Delivery app for cafeteria and flex areas to mainly service students on campus and surrounding off campus housing
Components to run the app:
Terminal
Ngrok
PostgreSQL database
Vape server
The onCamp app itself

SETTING UP THE VAPE SERVER:
The Vape server equipped with this app uses the Vapor framework, which enables Swift, a coding language, to be used as a backend language. These are the steps to running the Vape server:
1.	Install Ngrok via https://ngrok.com/ or npm. 
2.	In the terminal, run: ngrok http 8080.
This tells ngrok to tunnel your port 8080 to a randomized http and https URL in order for the Vape server to access your database data
3.	Copy the https URL and insert it into the url variable within the onCamp app in the menuTableViewController.swift file, then append the /menu router.
Example: let url = "https://dc966153.ngrok.io/menu"
This routes to the menu items in the database and populates the view upon running the app.
4.	Repeat this step in the loginScreenViewController.swift file, but append the /users route instead.
5.	Run the Vape server in Xcode. The server should now be running through port 8080 to the ngrok url routing to the menu items and users from the postgres database!


SETTING UP & VIEWING THE DATABASE:
This app uses a PostgreSQL database that can be easily manipulated and viewed through the Postico MacOS app. 
1.	Download postgreSQL via https://www.postgresql.org/download/ 
2.	Download free version of Postico via https://eggerapps.at/postico/ , or get the paid version from the Mac App Store(optional)
This step is optional, but it is recommended to easily manipulate the database with or without SQL. Otherwise, Postgres can be used within the terminal utilizing SQL.
3.	In Postico, create a database named campUsers. 
Set Host name to localhost
Set Port to 5432
Set User to your name
Connect
4.	Create two tables: one named MenuData and one named UserData. These are where the Vape routes connect. Populate the MenuData table with menu items for the app to make GET requests on via Alamofire in the menuTableViewController.swift file.
The app is currently set to GET the item, price, description, and restaurant, but an id column with the UUID datatype is needed to uniquely identify each item.

The UserData table should remain empty with the name, email, password, and school columns along with the UUID id column to store users, who will be POSTed there upon signing up when the user reaches the signupViewController.
