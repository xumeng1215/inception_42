DOCKER_COMPOSE_PATH = srcs/docker-compose.yml
all: up

# build images
build:
	docker compose -f $(DOCKER_COMPOSE_PATH) build

# start containers
# -d: detached mode
up:
	docker compose -f $(DOCKER_COMPOSE_PATH) up -d

# stop containers
# --volumes: remove named volumes declared in the `volumes` section
down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes

logs:
	docker compose -f $(DOCKER_COMPOSE_PATH) logs -f

clean:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes --rmi all

mk_data_dir:
	mkdir -p data/mariadb
	mkdir -p data/wordpress

reset_data_dir:
	rm -rf data/mariadb/*
	rm -rf data/wordpress/*

rebuild: down build up

.PHONY: all build up down logs clean mk_data_dir reset_data_dir rebuild