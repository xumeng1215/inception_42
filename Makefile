DOCKER_COMPOSE_PATH = srcs/docker-compose.yml

.PHONY: all build up down clean fclean create_data_dir reset_data_dir rebuild

all: create_data_dir build up

# build images
build:
	docker compose -f $(DOCKER_COMPOSE_PATH) build

# create and start containers
up:
	docker compose -f $(DOCKER_COMPOSE_PATH) up -d

# stop and remove containers
down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down

# stop containers
stop:
	docker compose -f $(DOCKER_COMPOSE_PATH) stop

# start containers
start:
	docker compose -f $(DOCKER_COMPOSE_PATH) start

# restart containers
restart:
	docker compose -f $(DOCKER_COMPOSE_PATH) restart

# remove containers and images 
clean:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes --rmi all

# remove containers, volumes, and images
fclean: clean reset_data_dir

create_data_dir:
	mkdir -p data/mariadb
	mkdir -p data/wordpress

reset_data_dir:
	rm -rf data/mariadb/*
	rm -rf data/wordpress/*

rebuild: fclean up

