#------------------------------------------------------------------------------#
#   CONFIG                                                                     #
#------------------------------------------------------------------------------#
ifndef VERBOSE
	MAKEFLAGS += --silent --no-print-directory
endif
MAKEFLAGS		+= --jobs

#------------------------------------------------------------------------------#
#   SOURCES                                                                    #
#------------------------------------------------------------------------------#
SOURCES_DIR	:= ./srcs/
COMPOSE		:= docker compose --project-directory ${SOURCES_DIR}
DATA		:= ${HOME}/data
VOLUMES		:= ${addprefix ${DATA}/, \
					wordpress \
					maridadb \
					info \
				}


#------------------------------------------------------------------------------#
#   COLORS                                                                     #
#------------------------------------------------------------------------------#
CRUSH	:= \r\033[K
ECHO	:= echo -n "$(CRUSH)"
R		:= $(shell tput setaf 1)
G		:= $(shell tput setaf 2)
END		:= $(shell tput sgr0)

#------------------------------------------------------------------------------#
#   RULES                                                                      #
#------------------------------------------------------------------------------#
all: up

up: create_dir
	${COMPOSE} up -d

down: down
	${COMPOSE} down

clean:
	${COMPOSE} down --rmi all

fclean:
	${COMPOSE} down --rmi all --volumes
	docker system prune -af
	sudo rm -rf ${VOLUMES}

re: fclean all

create_dir:
	mkdir -p ${VOLUMES}

#------------------------------------------------------------------------------#
#   SPEC                                                                       #
#------------------------------------------------------------------------------#
.PHONY: up down clean fclean re create_dir
.SILENT:
