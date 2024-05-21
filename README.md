# Introduction

This repository provides a `docker-compose.yml` ready-to-use Docker configuration to simplify the deployment of the official Keycloak Docker container for production use. If you want to use it for local development, this setup might not be the best choice. For comprehensive details about extra configurations, please refer to the [Keycloak official Docker installation guide](https://www.keycloak.org/getting-started/getting-started-docker).

## Repository Contents

This repository includes:

- **Docker Compose File**: A `docker-compose.yml` file that configures the Keycloak and PostgreSQL Docker containers. Highlights of this setup include:
  - **Persistent Data Storage**: Configures a volume:
    - `keycloak-db-data` at `/var/lib/postgresql/data` for storing PostgreSQL data.

    This setup ensures that your Keycloak configurations and data are preserved when the container is restarted.

- **Dockerfile**: Specifies the custom `Keycloak` Docker image build process, currently using Keycloak version 24.0.4. If you need to use a different version, modify the Dockerfile accordingly.

## Getting Started

### Important Preliminary Steps

Before starting the quick setup, please note the following adjustments:

1. **Environment Variables**: Modify the `.env` file in the root directory to change the default environment variable values to ones that suit your setup.
   ```env
   PG_PASSWORD=your_postgres_password
   KC_USER=admin
   KC_PASSWORD=your_admin_password
   KC_HOSTNAME=yourdomain.com
   ```

2. **Port Mapping**: The `docker-compose.yml` file contains a port mapping to `127.0.0.1`, limiting access to the localhost only. This setup is important for security in production when the reverse proxy is on the same server. If the reverse proxy is on a different server, you will need to change the IP address in the port mapping.

3. **Domain and Reverse Proxy**: This setup requires setting `KC_HOSTNAME` with a valid domain that points to the server. Additionally, a reverse proxy is necessary to handle HTTPS and forward traffic to the Keycloak service properly. Ensure your reverse proxy is correctly configured to point to the Keycloak service running on your server.

### Quick Setup

1. **Clone the Repository**:
   Clone this repository to your local machine using the following Git command:
   ```bash
   git clone https://github.com/yourusername/docker-keycloak.git
   cd docker-keycloak
   ```

2. **Build and Start Keycloak**:
   Use the following command to build the Keycloak image and start the service:
   ```bash
   docker compose up -d --build
   ```

3. **Access Keycloak**:
   Open a web browser and navigate to `https://yourdomain.com` (or the domain you configured in the `.env` file) to access the Keycloak web interface. Use the credentials you defined in the `.env` file.



