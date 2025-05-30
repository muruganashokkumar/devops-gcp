# Docker Basics

__What are docker image and docker containers?__

>Docker Images are Templates used to create Docker Container
>Container is a running instance of an image

## Basic Commands

* Version

```bash
docker -v
```

## Docker Images

* List of Images

```bash
docker images
```

* List of commands for images

```bash
docker images --help
```

* Pull an image (e.g., MySQL)

To pull a Docker image from the Docker Hub repository, use the `docker pull` command. This command downloads the specified image to your local machine.

```bash
docker pull mysql
docker pull ram1uj/easy-recipes

```
* Filtering images

```bash
docker images -f "dangling=true"
```

>Dangling images are images which are not associated with any containers

* Running an image

To run a Docker container from an image, use the `docker run` command. This command creates a new container from the specified image and starts it.

```bash
# Run a MySQL container
docker run -p 3309:3306 -e MYSQL_ROOT_PASSWORD=password --name mysql-container -d mysql

# Run the easy-recipes container
docker run -p 3000:80 --name easy-recipes-container -d ram1uj/easy-recipes
```

* Inspecting an image

```bash
docker inspect mysql
```

* Remove an Image

```bash
docker rmi mysql
```

## Docker Containers

* Show the list of running containers

```bash
docker ps
```

* Show the list of all containers

```bash
docker ps -a
```

* Start a container

```bash
docker start <container name/id>
```

* Stop a container

```bash
docker stop <container name/id>
```

* Pause a container

```bash
docker pause <container name/id>
```

* Resume a container

```bash
docker unpause <container name/id>
```

* Displaying stats

```bash
docker stats <container name/id>
```

* Remove a container

```bash
docker rm <container name/id>
```

* Get the history of an image

```bash
docker history <image name/id>
```

## Dockerfile

__What is a dockerfile?__

> A Dockerfile is a simple text file with instruction to build images
> Automation of docker image creation

![Dockerfile](https://i2.wp.com/miro.medium.com/max/1273/1*p8k1b2DZTQEW_yf0hYniXw.png?w=810&ssl=1)

__How to create a Dockerfile?__

* Step 1 : Create a file named Dockerfile

* Step 2 : Add instructions in Dockerfile

* Step 3 : Build Dockerfile to create image

* Step 4 : Run image to create container

### Dockerfile example

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
docker run -p 5000:8080 --name spring-boot-app-container -d spring-boot-app
```

### Access the Application on Port 8080
The Spring Boot application should now be accessible on `localhost:8080`.


## Docker Volume

> Docker volumes are used for decoupling container from storage

__Command to create a docker volume:__

```bash
docker volume create myVolume1
```


## Docker Mysql + SpringBoot

## How to run MySql on Docker -

  ```bash
   docker pull mysql
   docker run -d -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=mydb -e MYSQL_USER=docker -e MYSQL_PASSWORD=password -p 3306:3306 --name mysql mysql
  ```

## Docker Networking

> Docker networking is a way to connect multiple containers together

__Types of Docker Networking:__

* Bridge : Default network created when docker is installed
* Host : Removes network isolation between docker host and container
* None : No networking
* Overlay : Connect multiple docker daemons together
* Macvlan : Connects container directly to physical network
* Network Plugin : Third party networking plugin
* Vxlan : Connects container to physical network
* User Defined : Create custom network

__Commands:__

* List of networks

```bash
docker network ls
```

* Create a network

```bash
docker network create my-network
```

* Inspect a network

```bash

    docker network inspect my-network
    ```
    
* Connect a container to a network

```bash
docker network connect my-network mysql
```

* Disconnect a container from a network

```bash

    docker network disconnect my-network mysql
    ```
    
* Remove a network

```bash
docker network rm my-network
```


# Running a Spring Boot Application with a Database on Docker

To set up and run a Spring Boot application with a PostgreSQL (or MySQL) database in Docker, follow these steps.

## Steps:

### 1. Create a Docker Network
Create a dedicated Docker network to ensure communication between the Spring Boot application and the database container.

```sh
docker network create spring-boot-db-network
```

### 2. Run PostgreSQL/MySQL on the Network
Start the database container on the created network with the necessary environment variables.

```sh
docker run \
    --name postgres \
    -e POSTGRES_PASSWORD=password \
    --network=spring-boot-db-network \
    -p 5432:5432 \
    -d \
    postgres
```

### 3. Update the `application.yml` File
Configure your Spring Boot application to connect to the database. Update `application.yml` with the following content:

```yaml
spring:
    datasource:
        url: jdbc:postgresql://${POSTGRES_HOST:localhost}:${POSTGRES_PORT:5432}/${POSTGRES_DB:postgres}
        username: ${POSTGRES_USER:postgres}
        password: ${POSTGRES_PASSWORD:password}

    jpa:
        hibernate:
            ddl-auto: update
        show-sql: true
        properties:
            hibernate:
                format_sql: true
server:
    port: 8080
```

### 4. Create a Dockerfile for the Spring Boot App
Define the Dockerfile for the Spring Boot application to run in a container.

```Dockerfile
FROM openjdk:21-jdk-slim
WORKDIR /
ADD target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
```

### 5. Build the Docker Image
Build the Docker image for the Spring Boot application.

```sh
docker build -t todo-app .
```

### 6. Run the Spring Boot App Container on the Network
Run the application container, connecting it to the same Docker network.

```sh
docker run -p 8080:8080 \
    --name=todo-app \
    --network=spring-boot-db-network \
    -e POSTGRES_PORT=5432 \
    -e POSTGRES_DB=postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=password \
    -d todo-app
```

### 7. Access the Application on Port 8080
The Spring Boot application should now be accessible on `localhost:8080`.

### 8. Check Logs
To view the logs for troubleshooting or monitoring, use the following command:

```sh
docker logs [container-name]
```

