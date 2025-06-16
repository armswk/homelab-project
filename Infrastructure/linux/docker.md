ref: https://docs.docker.com/engine/install/debian/#install-using-the-repository

installing (Docker)

```java
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh

curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

apt install docker.io -y && apt install docker-compose -y

```

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

for alpine

[Docker - Alpine Linux](https://wiki.alpinelinux.org/wiki/Docker)

removing it

```java
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

Installing Compose // Also Update

```java
sudo apt-get update
sudo apt-get install docker-compose-plugin
```

check if running correcty

```java
docker compose version
Docker Compose version vN.N.N
```

verify

```java
docker ps
```

when no permission

```java
sudo usermod -aG docker <username>
sudo chmod 666 /var/run/docker.sock
```

try open a container

```java
docker run hello-world

//to check the container
docker ps -a
```

command

```java
docker run -dit --name <name> -p 8080:80 <appName>
docker run --name <name> -p 80:80 -d nginx
-d: for run in the background

docker pull <...>
docker run <...>
docker ps -a //check the container
docker rm <id/name> //remove the container
docker images //check what images are downloaded

network
ip a | grep docker0
docker network ls
docker network create <name>  //bridge-mode virtual host
docker run -d --name <name> --network host <Images> //you dont need to specify the port
   
ss -ltup //lookup opened port

docker compose up -d --build --force-recreate
```