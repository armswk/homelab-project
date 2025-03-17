######## Nginx Proxy Manager ########

## install Docker && Docker-Compose ##

apt install docker.io -y && apt install docker-compose -y

## create projekt directory and open it ##
mkdir npm && cd npm

## create docker congig.json ##
nano config.json

{
  "database": {
    "engine": "mysql",
    "host": "db",
    "name": "npm",
    "user": "npm",
    "password": "MYSQL_Password_changeme",
    "port": 3306
  }
}

## creacker docker-compose.yml ##
nano docker-compose.yml

version: "3"
services:
  app:
    image: jc21/nginx-proxy-manager:latest
    restart: always
    ports:
      - 80:80
      - 81:81
      - 443:443
    volumes:
      - ./config.json:/app/config/production.json
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - db
    environment:
    # if you want pretty colors in your docker logs:
    - FORCE_COLOR=1
  db:
    image: mariadb:latest
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: "username_changeme"
      MYSQL_DATABASE: "npm"
      MYSQL_USER: "username_changeme"
      MYSQL_PASSWORD: "password_changeme"
    volumes:
      - ./data/mysql:/var/lib/mysql
      
      
## build the conatiner ##
docker-compose up -d

## acess via web browser ##
http://hostip:81

## default login ##
user: admin@example.com
pw: changeme
