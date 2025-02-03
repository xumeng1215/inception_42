# Makefile

# Variables
DOCKER_COMPOSE_FILE=srcs/docker-compose.yml


all: build up

build:
	@echo "...building docker images for all services..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) build
up:
	@echo "...starting all containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d
down:
	@echo "...stop and removing all containers..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down
log:
	@echo "...showing logs for all services..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs --follow
clean:
	@echo "...clean up: removing containers, images and volumns..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) down --rmi all --volumes
re: clean all

.PHONY: all build up down logs clean re


