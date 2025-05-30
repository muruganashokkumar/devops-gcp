
### ** Create a Named Docker Network**
To allow communication between the MySQL container and your Spring Boot application:

```sh
docker network create my-app-network
```

This creates a **bridge network** named `my-app-network`.

---

### ** Create a Named Docker Volume**
To persist MySQL data even if the container restarts or is removed:

```sh
docker volume create my-app-mysql-data
```

---

### **Verify Network and Volume**
Check if the network was created:
```sh
docker network ls
```

Check if the volume was created:
```sh
docker volume ls
```

### ** Run MySQL with the Created Network and Volume**
```sh
docker run -d \
  --name mysql-container \
  --network my-app-network \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=notes_db \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=password \
  -p 3306:3306 \
  -v my-app-mysql-data:/var/lib/mysql \
  mysql:latest
```


---

### **4️⃣ Run Spring Boot App with the Created Network**
```sh
docker run -d \
  --name my-notes-app-container \
  --network my-app-network \
  -e DB_HOST=mysql-container \
  -e DB_PORT=3306 \
  -e DB_NAME=notes_db \
  -e DB_USER=root \
  -e DB_PASSWORD=password \
  -p 8080:8080 \
  my-notes-app
```




### ** To Remove the Network and Volume (Cleanup)**

```sh
docker network rm my-app-network
docker volume rm my-app-mysql-data
```
