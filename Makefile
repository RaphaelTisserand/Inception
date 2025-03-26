all:
	mkdir -p /home/rtissera/data/wordpress/ /home/rtissera/data/mariadb/
	sudo docker compose -f srcs/docker-compose.yml up

down:
	sudo docker compose -f srcs/docker-compose.yml down

clean: down
	sudo rm -rf /home/rtissera/data/wordpress/ /home/rtissera/data/mariadb/

re: clean
	make all
