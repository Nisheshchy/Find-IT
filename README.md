# Find It — Lost and Found Platform

FindIt is a modern lost and found platform designed to turn stressful losses into
successful returns. We leverage secure, real-time community tools to reunite users with
their lost belongings.

## Features

- **User Registration & Login** — Register with email, phone, and password; login with session-based authentication
- **Report Lost Items** — Post a lost item report with title, category, location, date, and contact preference
- **Report Found Items** — List found items to help reunite them with their owners
- **Edit Items** — Users can update their own item details (title, type, location, description, category)
- **Delete Items** — Users can remove their own reports; admins can remove any listing
- **Browse Listings** — Public browse page with filter by All / Lost / Found
- **Search** — Keyword search across item title, description, and location
- **Item Detail View** — Full detail page for each item showing all information and contact preferences
- **User Dashboard** — View personal reports with stats, edit, and delete actions
- **User Profile** — View and edit account information; change password
- **Admin Dashboard** — Overview statistics with recent submissions table
- **Admin User Management** — Approve or suspend user accounts
- **Admin Item Management** — Delete inappropriate listings
- **Admin Category Management** — Add or delete item categories
- **Session & Security** — Authentication filters, admin role protection, session timeout
- **Responsive Design** — Works on desktop, tablet, and mobile screens
- **Delete Confirmations** — All destructive actions prompt for user confirmation
- **About Page** — Information about the Find it platform.

## Technology Stack

- **Language:** Java 17 (Jakarta EE)
- **View Layer:** JSP + JSTL
- **Styling:** Pure CSS (no frameworks)
- **Database:** MySQL 8.x
- **Server:** Apache Tomcat 10+ / Jetty 11
- **Build:** Apache Maven
- **Architecture:** MVC (Model-View-Controller)

## Prerequisites

- **Java JDK 17+** — [Download](https://adoptium.net/)
- **Apache Maven 3.8+** — [Download](https://maven.apache.org/)
- **MySQL 8.x** — [Download](https://dev.mysql.com/downloads/)

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/NisheshChy/FindIt.git
cd FindIt
```

### 2. Set Up the Database

1. Start your MySQL server
2. Log into MySQL:
   ```bash
   mysql -u root -p
   ```
3. Run the SQL schema file:
   ```bash
   source findit_db.sql
   ```



### 3. Configure Database Connection

Edit `src/main/java/com/findit/dao/DBConnection.java` and set your MySQL root password:

```java
private static final String URL = "jdbc:mysql://localhost:3306/findit_db";
private static final String USER = "root";
private static final String PASSWORD = "";  // Set your MySQL root password here
```

### 4. Run the Project

Using the Jetty Maven plugin (recommended for development):

```bash
mvn clean compile jetty:run
```

Open your browser and navigate to: `http://localhost:8080/FindIt/`

Alternatively, for Tomcat deployment:

```bash
mvn clean package
```

Copy `target/FindIt.war` into your Tomcat `webapps/` directory, start Tomcat, and navigate to `http://localhost:8080/FindIt/`.



## User Workflow

1. **Register** a new account at `/register`
2. **Login** with your credentials at `/login`
3. **Browse** all items at `/browse` — search and filter by type (Lost / Found)
4. **Post** a lost or found item from your dashboard
5. **Edit** or **Delete** your own reports from the dashboard
6. **View Details** of any item to see full information and contact preferences
7. **Manage Profile** — update your name, phone, or password
8. **Logout** to end your session
9. **About** — Learn about the Find It platform

## Admin Workflow

1. Login with admin credentials
2. Access the **Admin Panel** from the navigation bar
3. **Manage Users** — approve pending accounts or suspend active ones
4. **Manage Items** — view and delete any listing
5. **Manage Categories** — add or remove item categories
