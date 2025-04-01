DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
all: up

build:
	docker compose -f $(DOCKER_COMPOSE_PATH) build

up:
	docker compose -f $(DOCKER_COMPOSE_PATH) up -d

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes --rmi all

stop:
	docker compose -f $(DOCKER_COMPOSE_PATH) stop

start:
	docker compose -f $(DOCKER_COMPOSE_PATH) start

logs:
	docker compose -f $(DOCKER_COMPOSE_PATH) logs -f

clean:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes --rmi all

rebuild: down build up

help:
	@echo "Makefile for Docker Project"
	@echo "Available commands:"
	@echo "  build   - Build Docker images"
	@echo "  up      - Start containers in detached mode"
	@echo "  down    - Stop and remove containers"
	@echo "  stop    - Stop running containers"
	@echo "  start   - Start stopped containers"
	@echo "  logs    - View logs of containers"
	@echo "  clean   - Remove containers, volumes, and images"
	@echo "  rebuild - Rebuild the images and restart containers"


