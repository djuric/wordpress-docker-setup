# 🧱 WordPress Dev Setup (Dockerized)

This repository offers a minimal Docker-based setup for WordPress development, enabling you to spin up a local environment quickly without complex configuration.

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/djuric/wordpress-docker-setup myproject
cd myproject
```

### 2. Set Up Your .env file

Edit `.env` file in the project root and configure the following variables:

```bash
PROJECT_NAME=yourproject
WORDPRESS_PORT=8080
PHPMYADMIN_PORT=8081
MYSQL_PORT=3306
```

`PROJECT_NAME` - The name you want to give your project. This will be used as the prefix for Docker container names.

`WORDPRESS_PORT` - The port number you want to use for the WordPress container.

`PHPMYADMIN_PORT` - The port number you want to use for the phpMyAdmin container.

`MYSQL_PORT` - The port number you want to use for the MySQL container.

### 3. Start the Project

Rather then using `docker compose` (there are multiple options to pass environment variables), use the `start.sh` script to start the project:

```bash
./start.sh
```
This will:

- Load environment variables from `.env`
- Assign a unique Docker Compose project name


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
