
## Docker Compose

__What is Docker compose?__

* Tool for defining and running multi-container Docker application
* It uses yaml file to configure application services(docker-compose.yml)
* Can start all services with a single command
* Can scale up selected services when required

## Steps

* Step 1 : Create the docker compose file (docker-compose.yml)
* Step 2 : Check the validity of the file using command:

```bash
docker-compose config
```

* Step 3 : Run docker-compose yml file using command:

```bash
docker-compose up
```

* Step 4 : Stop docker-compose using command:

```bash
docker-compose down
```

__docker-compose.yml exmaple:__

```yml

version: '3'

services:
    web:
        image: nginx
        ports:
            - 9090:80
    database:
        image: redis

```

__How to use scaling?__

```bash
docker-compose up -d --scale spring-boot-app=4
```

### Running Spring Boot App with MySQL Database using Docker Compose


# Docker Notes and Commands

## Pull an image (e.g., MySQL)

To pull a Docker image from the Docker Hub repository, use the `docker pull` command. This command downloads the specified image to your local machine.

```bash
docker pull mysql
docker pull ram1uj/easy-recipes

```

### Run the image

To run a Docker container from an image, use the `docker run` command. This command creates a new container from the specified image and starts it.

```bash
# Run a MySQL container
docker run -p 3309:3306 -e MYSQL_ROOT_PASSWORD=password --name mysql-container -d mysql

# Run the easy-recipes container
docker run -p 3000:80 --name easy-recipes-container -d ram1uj/easy-recipes
```


## How to build a Docker Image for Spring Boot Application

To build a Docker image for a Spring Boot application, you need to create a `Dockerfile` that contains the instructions for assembling the image.

```dockerfile
FROM openjdk:21-jdk-slim
WORKDIR /
ADD target/spring-boot-app.jar app.jar
CMD ["java", "-jar", "app.jar"]

```

## How to build the image

To build the Docker image using the `Dockerfile`, use the `docker build` command. This command reads the `Dockerfile` and creates the image.

```bash
docker build -t spring-boot-app .
```

## Run the Image

To run the Docker image you built, use the `docker run` command. This command creates and starts a new container from the image.

```bash
docker run -p 8900:8080 --name spring-boot-app-container -d spring-boot-app
```



## Docker Compose to Simplify Multi-Container Applications

When you have multiple containers that need to work together, managing them individually can be complex.

You can simplify the setup with Docker Compose.

### 1. Create a `docker-compose.yml` File
Add the following content to `docker-compose.yml`:

```yaml
version: '3.7'
services:

    postgres:
        image: postgres
        ports:
            - "5432:5432"
        restart: always
        environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: password
            POSTGRES_DB: postgres
        networks:
            - app-network

    todo-app:
        image: todo-app
        ports:
            - "8080:8080"
        restart: always
        depends_on:
            - postgres
        networks:
            - app-network
        environment:
            POSTGRES_HOST: postgres
            POSTGRES_PORT: 5432
            POSTGRES_DB: postgres
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: password

networks:
    app-network:
```

### 2. Validate the `docker-compose.yml` File
Ensure the YAML file syntax is correct:

```sh
docker compose config
```

### 3. Start the Application
Run the following command to start the application:

```sh
docker compose up -d
```

### 4. Stop the Application
To stop the containers, use:

```sh
docker compose down
```

## How to Install Docker and Docker Compose on AWS

To set up Docker and Docker Compose on an AWS instance:

### 1. Install Docker

```sh
sudo yum install docker -y
sudo service docker start
```

### 2. Add the EC2 User to the Docker Group

```sh
sudo usermod -a -G docker ec2-user
```

### 3. Install Docker Compose
Download Docker Compose:

```sh
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```

### Note: For the latest version, use:

### 4. Set Executable Permissions

```sh
sudo chmod +x /usr/local/bin/docker-compose
```

### 5. Verify Installation

```sh
docker-compose version
```



### Some useful Docker Compose Commands

* Docker-compose Configuration

```bash
docker-compose config
```

* Docker-Compose Images Used

```bash
docker-compose images
```

* Docker-Compose Container Used

```bash
docker-compose ps
```

* Docker-Compose Pause, Resume, Stop, Kill

```bash
docker-compose pause
docker-compose unpause
docker-compose stop
docker-compose kill

```


* Docker-Compose Events

```bash
docker-compose events
```


* Build Images from Dockerfile

```bash
docker-compose build

```

