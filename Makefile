VOLUME_PATH=/home/raph/data
DOCKER=docker
CONTAINER=$(DOCKER) container
COMPOSE_FILE=srcs/docker-compose.yml
COMPOSE=$(DOCKER) compose -f  $(COMPOSE_FILE) 
VOLUME=$(DOCKER) volume
IMAGE=$(DOCKER) image
all: create_dir compose/up-build

create_dir:
	mkdir -p $(VOLUME_PATH)/db $(VOLUME_PATH)/static

compose/%:
	$(COMPOSE) $(@F) 
.PHONY: compose/% 

compose/up-build:
	$(COMPOSE) up --build 
.PHONY: compose/up-build


bash/%:
	$(CONTAINER) exec -it $(@F) bash
.PHONY: bash/%

clean/containers:
	$(CONTAINER) rm -f $$($(CONTAINER) ls -aq)
.PHONY: clean/containers

clean/volumes:
	$(VOLUME) rm -f $$($(VOLUME) ls -q)
.PHONY: clean/volumes

clean/images:
	$(IMAGE) rm -f $$($(IMAGE) ls -q)

clean/buildx:
	$(DOCKER) buildx prune -f

nuke/all: clean/images clean/volumes clean/buildx clean/containers

.PHONY: clean/all


rebuild: clean compose/build all
.PHONY: rebuild

clean: compose/down
	sudo rm -rf $(VOLUME_PATH)/db $(VOLUME_PATH)/static
.PHONY: clean

re: clean
	make all
.PHONY: re
