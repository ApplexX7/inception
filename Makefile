WP_DATA := /home/$(shell echo $$USER)/data/wordpress
DB_DATA := /home/$(shell echo $$USER)/data/mariadb

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
	# Stop all containers (only if containers exist)
	@containers=$$(docker ps -qa); \
	if [ -n "$$containers" ]; then \
		docker stop $$containers; \
		docker rm $$containers; \
	fi
	
	# Remove all images (only if images exist)
	@images=$$(docker images -qa); \
	if [ -n "$$images" ]; then \
		docker rmi -f $$images; \
	fi
	
	# Remove all volumes (only if volumes exist)
	@volumes=$$(docker volume ls -q); \
	if [ -n "$$volumes" ]; then \
		docker volume rm $$volumes; \
	fi
	
	# Remove all networks (only if networks exist, and not pre-defined ones)
	@networks=$$(docker network ls -q); \
	for network in $$networks; do \
		if [[ "$$network" != "bridge" && "$$network" != "host" && "$$network" != "none" ]]; then \
			docker network rm $$network; \
		fi \
	done
	
re: clean up

prune: clean
	docker system prune -a --volumes -f

