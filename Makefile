# ---------------------------------------------------------------------------- #
#   UTILS                                                                      #
# ---------------------------------------------------------------------------- #
ifndef VERBOSE
	MAKEFLAGS	+= --silent --no-print-directory
endif
# MAKEFLAGS	+= --jobs
ERR_MUTE	:= 2>/dev/null

# ---------------------------------------------------------------------------- #
#   VARIABLES                                                                  #
# ---------------------------------------------------------------------------- #
SOURCES_FOLDER	:=	./srcs
COMPOSE		:=	docker compose --project-directory ${SOURCES_FOLDER}
SYSTEM		:=	docker system
DATA		:=	${HOME}/data
VOLUMES		:=	${addprefix ${DATA}/, wordpress mariadb}

# ---------------------------------------------------------------------------- #
#   COLORS                                                                     #
# ---------------------------------------------------------------------------- #
# How use it:
# $(ECHO)"$(YOURCOLOR)Some random colored text...$(END) Some uncolored text...\n"
CRUSH		:= \r\033[K
ECHO		:= echo -n "$(CRUSH)"
R		:= $(shell tput setaf 1)
G		:= $(shell tput setaf 2)
END		:= $(shell tput sgr0)

# ---------------------------------------------------------------------------- #
#   RULES                                                                      #
# ---------------------------------------------------------------------------- #
all: up

.PHONY: clean
clean:
	$(COMPOSE) down --rmi all --volumes

.PHONY: fclean
fclean: clean
	$(SYSTEM) prune -f -a --volumes
	sudo rm -r -f $(VOLUMES)

.PHONY: re
re: fclean all

.PHONY: dre
dre: clean all

.PHONY: up
up: create_dir build create
	$(COMPOSE) up --build -d

.PHONY: stop down build create
stop down build create:
	$(COMPOSE) $@

.PHONY: create_dir
create_dir:
	mkdir -p $(VOLUMES)

.PHONY: ps
ps:
	$(COMPOSE) $@ -a

.PHONY: info-%
info-%:
	$(MAKE) --dry-run --always-make $* | grep -v "info"

# .SILENT:
