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
```

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
  The port exposed on your host for connecting to the MariaDB database.  
  Useful if you plan to connect with tools like DBeaver or MySQL Workbench.

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
