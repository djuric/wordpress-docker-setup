# 🧱 WordPress Dev Setup (Dockerized)

This repository offers a minimal Docker-based setup for WordPress development, enabling you to spin up a local environment quickly without complex configuration.

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/djuric/wordpress-docker-setup myproject
cd myproject
```

### 2. Set Up Your `.env` File

Create a `.env` file in the project root and configure the following variables:

```env
PROJECT_NAME=yourproject
WORDPRESS_PORT=8080
PHPMYADMIN_PORT=8081
MYSQL_PORT=3306

WORDPRESS_DB_USER=exampleuser
WORDPRESS_DB_PASSWORD=examplepass
WORDPRESS_DB_NAME=exampledb
```

**IMPORTANT**: Your `PROJECT_NAME` needs to be the same as the name of your project folder. Docker containers and volumes will be named based on this prefix.

#### 🔍 What Each Variable Does

- **`PROJECT_NAME`**  
  A unique name for your project. Used as a prefix for Docker containers, volumes, and networks to avoid conflicts with other projects.

- **`WORDPRESS_PORT`**  
  The port on your host machine used to access the WordPress site.  
  Example: `http://localhost:8080`

- **`PHPMYADMIN_PORT`**  
  The port used to access phpMyAdmin (database management UI).  
  Example: `http://localhost:8081`

- **`MYSQL_PORT`**  
  The port exposed on your host for connecting to the database.  
  Useful if you plan to connect with tools like DBeaver or MySQL Workbench.

- **`WORDPRESS_DB_USER`**  
  The username for accessing the database.

- **`WORDPRESS_DB_PASSWORD`**  
  The password for accessing the database.

- **`WORDPRESS_DB_NAME`**  
  The name of the database.

> **Note:** If you're running multiple instances of this setup, make sure each one uses a unique set of ports (e.g. 8080/8081/3306 for one, 8090/8091/3307 for another).

### 3. Start the Project

Instead of using `docker compose` manually (which requires extra flags to load environment variables), use the included `start.sh` script:

```bash
./start.sh
```

This will:

- Load environment variables from `.env`
- Apply a unique Docker Compose project name using `PROJECT_NAME`


## 🔀 Running Multiple Instances

To run multiple instances of this Docker setup (e.g., for different WordPress projects), you'll need to assign **unique port numbers** for each one to avoid conflicts.

### ✅ Guidelines for Choosing Ports

- Use port numbers **above 1024** (to avoid reserved system ports).
- Ensure the ports are **not already in use** by another process or Docker container.
- Avoid commonly used ports like `5432` (PostgreSQL), `6379` (Redis), etc., unless you're sure they're not active.

### 🧩 Example Port Assignments

| Instance | WordPress | phpMyAdmin | MySQL |
|----------|-----------|------------|--------|
| siteA    | 8080      | 8081       | 3306   |
| siteB    | 8090      | 8091       | 3307   |
| siteC    | 8100      | 8101       | 3308   |

## 🛠 WP-CLI Support

This setup includes [WP-CLI](https://wp-cli.org/) preinstalled in the WordPress container. You can run WP-CLI commands directly from your terminal using the provided `./wp.sh` script.

First, ensure the script is executable:

```bash
chmod +x wp.sh
```

Then you can run commands like:

```bash
./wp user list
./wp plugin install akismet --activate
./wp post list
```

> ✅ No need to type `docker compose exec` — the script handles it for you.
> 
> ❗ Make sure the project is up and running via `./start.sh` before using WP-CLI commands.

---

## 📥 Importing the Database

You can import a `.sql` file into your running MySQL container using the included `mysql-import.sh` script.

Ensure the script is executable:

```bash
chmod +x mysql-import.sh
```

Run the import command:

```bash
./mysql-import.sh path/to/your-database-dump.sql
```

This will:
- Copy the SQL file into the running MySQL container
- Run the import inside the container using credentials from your `.env` file

> 💡 If you're importing a full website, make sure the database you are importing into already exists and is completely empty (i.e., contains no tables).

## 🔄 Update URLs After Import (Search & Replace)

After importing a database, you may need to update old URLs (e.g., from a production domain to `localhost`).

Use WP-CLI's `search-replace` command:

```bash
./wp search-replace 'https://old-domain.com' 'http://localhost:8080'
```

> 💡 Adjust the port (`8080`) to match your current WordPress port if needed.

## 📤 Exporting the Database

You can export your project's current database using the included `mysql-export.sh` script.

Ensure the script is executable:

```bash
chmod +x mysql-export.sh
```

Run the export command:

```bash
./mysql-export.sh
```

This will:
- Export the contents of your database using the credentials from `.env`
- Save the dump as a `.sql` file in the project root directory
