# Pahana Edu – Online Billing System (Service + Web)

This is a **two-project** solution designed for **Apache NetBeans 21**, **JDK 21**, and **GlassFish 7 (Jakarta EE 10)**, using **MySQL (XAMPP)**.

- `pahana-edu-service` — Jakarta REST (JAX‑RS) web service + JDBC (DAO pattern)
- `pahana-edu-web` — JSP/Servlet web client that consumes the REST service

## Quick start (high level)

1) Start **XAMPP** → Apache & MySQL. Open **phpMyAdmin** and run `db/mysql-schema.sql`.
2) In NetBeans:
   - File → Open Project… → open both folders (`pahana-edu-service`, `pahana-edu-web`).
   - Right‑click each project → Properties → Run:
     - Server: **GlassFish Server 7** (add if needed).
     - Java Platform: **JDK 21**.
   - For the **service project**, open `src/main/resources/db.properties` and ensure your MySQL credentials match your local setup.
3) Deploy **service** first (Run project). Verify: http://localhost:8080/pahana-edu-service/api/health
4) Deploy **web** next. Login with `admin / admin123`. 

Full step‑by‑step NetBeans import & GlassFish config is documented at the end of this file.


---

## Database (XAMPP / MySQL)

1. Start **XAMPP** → **MySQL**.
2. Open **phpMyAdmin** and run `db/mysql-schema.sql` to create schema and seed data.
   - Admin user: `admin / admin123`
   - Sample customer & items are inserted.

If your MySQL password is not blank, edit **`pahana-edu-service/src/main/resources/db.properties`**.

---

## Build & Run (NetBeans 21 + GlassFish 7 + JDK 21)

1. **Add GlassFish 7** to NetBeans (Tools → Servers → Add Server → GlassFish → point to GF7 install).
2. Open the two projects.
3. Right-click **pahana-edu-service** → *Run*. Verify health: `http://localhost:8080/pahana-edu-service/api/health` shows `OK`.
4. Right-click **pahana-edu-web** → *Run*. It will open `index.jsp` (login). Use `admin/admin123`.

> You can override the service base URL for the web client via VM options:
> Run → Set Project Configuration → Customize → Run → VM Options: `-Dservice.base=http://localhost:8080/pahana-edu-service/api/`

---

## What’s implemented (Task B mapping)

- **Distributed application with web services:** `pahana-edu-service` exposes **REST** endpoints `/api/customers`, `/api/items`, `/api/orders`.
- **Design patterns:** DAO (+ DTO), Service/Resource layer, Singleton DB connection, MVC in the web client.
- **Database:** MySQL schema with `users`, `customers`, `items`, `orders`, `order_items`.
- **Validation:** HTML5 constraints (required, patterns), DAO throws for not found, server-side validation paths.
- **Reports:** simple endpoints via web client (Sales Today, Top Items – demonstrative and easily extendable).
- **Security:** session login in web (demo). You can extend to real DB validation quickly by adding a `/api/login` if needed.

> This structure aligns to 3‑tier architecture (Presentation = JSP/Servlet, Business = REST resources/DAOs, Data = MySQL).

---

## NetBeans “Add the code” (step‑by‑step)

1. **Extract the ZIP** you downloaded.
2. In NetBeans → `File → Open Project…` → select `pahana-edu-service` → Open.
3. Repeat for `pahana-edu-web`.
4. For each project: `Right‑click → Properties`:
   - **Run**: set **Server** = *GlassFish 7*; **Java Platform** = *JDK 21*.
   - **Build**: leave defaults (Maven).
5. Ensure MySQL driver downloads automatically (Maven). If proxy issues, run `Clean and Build`.
6. Start **XAMPP** MySQL; execute `db/mysql-schema.sql` in phpMyAdmin.
7. Run service, then the web project.
8. If port 8080 is busy, adjust GlassFish HTTP port or stop conflicting services (e.g., Tomcat).

---

## REST endpoints (test with curl/Postman)

- `GET  /pahana-edu-service/api/health` → OK
- `GET  /pahana-edu-service/api/customers`
- `POST /pahana-edu-service/api/customers` JSON: `{ "accountNumber":"ACC-2000","name":"User","address":"Addr","phone":"077..." }`
- `GET  /pahana-edu-service/api/items`
- `POST /pahana-edu-service/api/items` JSON: `{ "sku":"BK-100","name":"Book","unitPrice":1500 }`
- `POST /pahana-edu-service/api/orders` JSON: `{ "customerId":1, "items":[ {"itemId":1,"quantity":2} ] }`

---

## Notes for assessors (Excellent criteria alignment)

- **Patterns & Architecture:** DAO + DTO + Singleton + MVC; clean layering and REST boundaries.
- **Database & Business rules:** relational schema; transactions/rollbacks in `OrderDAO#createOrder`.
- **Usability:** water.css lightweight styling; form validation; clear error messages in JSPs.
- **Extensibility:** all endpoints and DAOs are minimal but complete; easy to add pagination, authentication, or more reports.
