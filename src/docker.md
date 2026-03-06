# Docker

> build once, run anywhere. no more "works on my machine".

---

## what is Docker

Docker is a tool that packages your application and all its dependencies into a **container** — a lightweight, isolated environment that runs the same everywhere.

**the problem it solves:**
```
developer 1: "it works on my machine"
developer 2: "it crashes on mine"
production:  "completely broken"

reason: different OS, different Python version, different library versions,
        different environment variables, different system config
```

**with Docker:**
```
you define exactly what environment your app needs
Docker creates that environment everywhere identically
works the same on your laptop, teammate's laptop, server
```

**containers vs virtual machines:**
- VM: full OS, heavy (GBs), slow to start (minutes)
- Container: shares OS kernel, lightweight (MBs), starts in seconds

---

## core concepts

**image** — blueprint for a container. built from a Dockerfile. like a class in OOP.

**container** — a running instance of an image. like an object (instance of a class).

**Dockerfile** — text file with instructions to build an image.

**Docker Hub** — registry of public images. like npm for Docker.

**docker-compose** — tool to define and run multi-container apps (frontend + backend + database).

```
Dockerfile → docker build → Image → docker run → Container
```

---

## install Docker

```bash
# Ubuntu/Linux Lite
sudo apt update
sudo apt install docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

# add your user to docker group (no sudo needed)
sudo usermod -aG docker $USER
newgrp docker

# verify
docker --version
docker run hello-world
```

---

## Dockerfile

a Dockerfile is a recipe for building an image.

```dockerfile
# FastAPI backend Dockerfile
FROM python:3.11-slim

# set working directory inside container
WORKDIR /app

# copy requirements first (for layer caching)
COPY requirements.txt .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy rest of code
COPY . .

# expose port
EXPOSE 8000

# command to run when container starts
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```dockerfile
# React frontend Dockerfile (multi-stage build)
# stage 1: build
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# stage 2: serve (much smaller final image)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

```dockerfile
# Python script/tool Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# for scripts (not servers)
ENTRYPOINT ["python", "main.py"]
```

**Dockerfile instructions:**
```dockerfile
FROM image:tag        # base image to start from
WORKDIR /path         # set working directory
COPY src dest         # copy files from host to image
RUN command           # run command during build
ENV KEY=VALUE         # set environment variable
EXPOSE 8080           # document which port to expose
CMD ["cmd", "arg"]    # default command when container starts
ENTRYPOINT ["cmd"]    # main command (CMD provides default args)
ARG VAR=default       # build-time variable
VOLUME /path          # mount point for external storage
```

---

## building and running images

```bash
# build image from Dockerfile in current directory
docker build -t my-app .
docker build -t my-app:v1.0 .        # with tag
docker build -t my-app -f Dockerfile.prod .  # specific Dockerfile

# run container
docker run my-app
docker run -p 8000:8000 my-app       # map host:container port
docker run -p 3000:80 my-app         # host 3000 → container 80
docker run -d my-app                 # detached (background)
docker run -d --name my-api my-app   # with name
docker run -it my-app bash           # interactive shell

# environment variables
docker run -e DATABASE_URL=postgres://... my-app
docker run --env-file .env my-app

# volumes (persist data)
docker run -v /host/path:/container/path my-app
docker run -v $(pwd):/app my-app     # mount current directory

# full example
docker run -d \
    --name studentos-api \
    -p 8000:8000 \
    --env-file .env \
    -v $(pwd)/uploads:/app/uploads \
    my-app
```

---

## managing containers

```bash
# list
docker ps              # running containers
docker ps -a           # all containers including stopped

# stop/start/restart
docker stop container_name
docker start container_name
docker restart container_name

# remove
docker rm container_name          # remove stopped container
docker rm -f container_name       # force remove running container

# logs
docker logs container_name
docker logs -f container_name     # follow (live)
docker logs --tail 50 container_name  # last 50 lines

# execute command in running container
docker exec -it container_name bash   # open shell
docker exec container_name ls -la     # run command

# copy files
docker cp container_name:/app/file.txt .   # container to host
docker cp file.txt container_name:/app/    # host to container

# inspect
docker inspect container_name     # detailed info
docker stats                       # live resource usage
```

---

## managing images

```bash
# list images
docker images
docker image ls

# remove image
docker rmi image_name
docker rmi image_name:tag
docker image prune           # remove unused images

# pull from Docker Hub
docker pull python:3.11
docker pull postgres:16
docker pull nginx:alpine

# push to Docker Hub
docker login
docker tag my-app username/my-app:v1.0
docker push username/my-app:v1.0

# view image layers
docker history image_name
```

---

## docker-compose

docker-compose defines multi-container applications in one file. instead of running multiple docker run commands, you run one command.

```yaml
# docker-compose.yml
version: "3.9"

services:

  # FastAPI backend
  api:
    build: ./backend
    container_name: studentos-api
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/studentos
      - JWT_SECRET=${JWT_SECRET}
    env_file:
      - ./backend/.env
    volumes:
      - ./backend:/app    # mount code for hot reload
    depends_on:
      - db
    restart: unless-stopped

  # React frontend (development)
  frontend:
    build: ./frontend
    container_name: studentos-frontend
    ports:
      - "5173:5173"
    volumes:
      - ./frontend:/app
      - /app/node_modules   # don't override container's node_modules
    environment:
      - VITE_API_URL=http://localhost:8000
    depends_on:
      - api

  # PostgreSQL database
  db:
    image: postgres:16-alpine
    container_name: studentos-db
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_DB=studentos
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data   # persist data
    restart: unless-stopped

  # Redis cache
  redis:
    image: redis:7-alpine
    container_name: studentos-redis
    ports:
      - "6379:6379"
    restart: unless-stopped

volumes:
  postgres_data:    # named volume for database data
```

```bash
# start everything
docker-compose up
docker-compose up -d         # detached
docker-compose up --build    # rebuild images first

# stop everything
docker-compose down
docker-compose down -v       # also remove volumes (deletes data)

# logs
docker-compose logs
docker-compose logs api      # specific service
docker-compose logs -f       # follow

# restart specific service
docker-compose restart api

# run command in service
docker-compose exec api bash
docker-compose exec db psql -U postgres

# rebuild specific service
docker-compose up -d --build api
```

---

## .dockerignore

like .gitignore — tells Docker what NOT to copy into the image.

```dockerignore
node_modules
.git
.env
.env.local
dist
build
__pycache__
*.pyc
.pytest_cache
*.log
.DS_Store
```

---

## real world project structure

```
my-project/
├── docker-compose.yml          # development
├── docker-compose.prod.yml     # production
├── frontend/
│   ├── Dockerfile
│   ├── Dockerfile.prod
│   ├── .dockerignore
│   ├── nginx.conf
│   └── src/
├── backend/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── requirements.txt
│   └── main.py
└── .env                        # shared environment variables
```

---

## useful Docker commands

```bash
# system cleanup
docker system prune              # remove stopped containers, unused images
docker system prune -a           # also remove all unused images
docker volume prune              # remove unused volumes

# disk usage
docker system df

# network
docker network ls
docker network create my-network
docker run --network my-network my-app

# pull, build and push shortcut
docker buildx build --platform linux/amd64,linux/arm64 -t username/app:latest --push .
```

---

## Docker for your projects

**StudentOS local development:**
```bash
# no more manual setup for new teammates
git clone repo
docker-compose up
# app runs at localhost:5173, api at localhost:8000
```

**knowledge hub:**
```yaml
services:
  web:
    build: .
    ports: ["3000:3000"]
  db:
    image: postgres:16-alpine
```

**private chat app:**
```yaml
services:
  app:
    build: .
  db:
    image: postgres:16-alpine
  redis:
    image: redis:7-alpine  # for WebSocket sessions
```

---

```
=^._.^= if it runs in Docker, it runs everywhere
```
