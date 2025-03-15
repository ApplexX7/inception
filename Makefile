WP_DATA = /home/data/wordpress
DB_DATA = /home/data/mariadb

all: up

up: build
	@makdir -p $(WP_DATA)
	@makdir -p $(DB_DATA)
	docker-compose -f ./Docker-compose.yml up -d

down:
	docker-compose -f ./Docker-compose.yml down

stop:
	docker-compose -f ./Docker-compose.yml stop

start:
	docker-compose -f ./Docker-compose.yml start

build:
	docker-compose -f ./Docker-compose.yml build


clean:
	docker stop $$(docker ps -qa)
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q)
	rm -rf $(WP_DATA)
	mr -rf $(DB_DATA)

re : clean up

prune: clean
	docker system prune -a --volumes -f

