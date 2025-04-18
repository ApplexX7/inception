WP_DATA = /home/mohilali/data/wordpress
DB_DATA = /home/mohilali/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./src/docker-compose.yml up -d

down:
	docker-compose -f ./src/docker-compose.yml down

stop:
	docker-compose -f ./src/docker-compose.yml stop

start:
	docker-compose -f ./src/docker-compose.yml start

build:
	docker-compose -f ./src/docker-compose.yml build

clean:
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	docker rmi -f $$(docker images -qa) || true
	docker volume rm $$(docker volume ls -q) || true
	docker network rm $$(docker network ls -q) || true
	rm -rf $(WP_DATA)
	rm -rf $(DB_DATA)

re: clean up

prune:
	docker system prune -a --volumes -f

