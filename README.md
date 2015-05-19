# My Wine Cellar

This application can be used to manage a personal wine cellar.
by [Alan Michels](mailto:sf.michels@gmail.com)

The original version of this database was built using FilemakerPro on MacOS. It was an old version that didn't even use
SQL. It uses old technology and resides on a single computer. The two main screens are for:

### Main screen used for Entry and Display (Legacy Filemaker Pro Database)
![Enter and Display a Bottle](/app/assets/images/WineCellarNouveauEntryAndDisplay.png)

### Screen used for displaying Query Results (Legacy Filemaker Pro Database)
![List results of a query](/app/assets/images/WineCellarNouveauList.png)

## New Wine Cellar App

I am implementing a modern replacement for the original program. Its goals are:

* Support all the features from the existing program.
* Create a migration path for the existing data.
* Display on multiple devices:
    * Computer
    * Smart Phone
    * Tablet
* Responsive Design (look good on different devices)

## Technical Goals

I am also using this project to learn web programming with Ruby on Rails. The features that I have learned are:

* Ruby Programming Language
* Create a rails project
* Implement via MVC: Model, View, Controller
* Learn git
* Normalize the data model. The Filemaker program kept track of bottles. The information about the wines were
duplicated for each bottle. The new data model has both wines and bottles. Each bottle is an instance of a wine.
* Create routes for REST

## Features

* Create a migration path for moving the data from FilemakerPro to the rails database.
I converted the FilemakePro data to json and the wrote a ruby script to populate the new database.
The migration script automatically fixed some issues.
    * Vertical tabs (ascii 10) were converted to new lines.
    * Some of the maturity dates were of the form "2005-2020". The first year was the actual maturity date and the
    second date was really the "drink by" date. The migration script just put in the first date. (The "drink by" always
    had its own field when it was known.)
    * If "drink by" was an empty string it was converted to nil since types are enforced.
    * If "drink by" was "soon", then it was converted to the current year.
    * Vintage and Maturity were set to nil if there wasn't a known date.
    * Each record in the FilemakerPro database had 19 fields. 14 of the fields were attributes of the wine and only 5
    of the fields were related to the particular bottle. The migration normalized the data by using a wine class that
    that can have many bottles. The Wine object was only created once by using the first_or_create method. This only
    added the wine to the database once but allowed multiple bottles to be created.


* Implement Web Pages:
    * Create a New Wine
    * Edit a Wine
    * Show a Wine
    * Search / Show List of Wines
    * Add Bottles (on the Show a Wine Page)

* Implement Search using Ransack
* Responsive Design using Bootstrap
* Pagination using Kaminari
* Deployed using Heroku

## Lessons Learned

* Use the same database in development and production. I was developing with the default SQLite database and deploying
to heroku which used Postgresql. I didn't discover that some of my string fields were holding values that needed to be
text fields until I started migrating the real data.
* The ruby documentation, rails documentation and google search are your friends. I started to implement my own
specialized first_or_create for migrating data but then I looked it up and found the it was part of rails.




