# Online Recipe Sharing Platform

A full-stack Java web application designed with MVC architecture, JDBC connectivity, and MySQL persistence for community-driven culinary discovery and recipe management.

Developed for **GUVI - Galgotias Project Board 3rd Sem (Review 1)**  
**Student:** Sachin (25SCSE1410011)  
**Team:** Team E, Galgotias University  

## Tech Stack
- **Java 17** • Servlets • JSP (with JSTL)
- **JDBC** • MySQL 8
- **Maven** (`mvn jetty:run`)
- **Bootstrap 5** (Responsive Grid, Dark Mode toggle)

## Project Structure
```
database/
   schema.sql          MySQL normalized tables
   seed.sql            Starter seed data
   migration_phase_b.sql Migration updates
src/main/java/com/recipe/
   model/     User, Admin (inherits User), Recipe
   dao/       UserDAO, RecipeDAO (interfaces) + JDBC implementations
   servlet/   Servlets (request handling & routing)
   filter/    AuthFilter (session authentication & role protection)
   util/      DBConnection, PasswordUtil, DatabaseException
src/main/resources/db.properties   Database credentials & config
src/main/webapp/
   css/style.css                   Custom styling & dark mode
   WEB-INF/views/                  Secure JSP views (/admin, /user, /common)
```

## Features (Review 1 Deliverables)
- **MVC Architecture:** Strict separation between Presentation (JSP), Business/Controller (Servlets), and Data Access (DAO).
- **Core Java & OOP:** Polymorphism with DAO interfaces, Inheritance (`Admin extends User`), Collections, Generics, and custom `DatabaseException`.
- **Database Integration:** Normalized relational MySQL schema, foreign keys with cascade/restrict, thread-safe `DBConnection.java`, and parameterized `PreparedStatement` queries against SQL injection.
- **Web Security:** `AuthFilter` session verification guarding `/user/*` and `/admin/*` routes.
- **Modern Responsive UI:** Bootstrap 5 recipe discovery, culinary hero banner, instant filtering, and ingredient checklists.

## Setup & Running
1. Import schema: `mysql -u root -p < database/schema.sql`
2. Configure credentials in `src/main/resources/db.properties`
3. Run with Maven: `mvn jetty:run`
4. Open `http://localhost:8080/recipe/` in your browser.
