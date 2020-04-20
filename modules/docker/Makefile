DOCKER:= $(shell which docker 2>/dev/null)
DOCKER_RUN?=docker run -i --rm --network=$(DOCKER_NETWORK)
DOCKER_EXEC?=$(DOCKER) exec -it
DOCKER_SERVICE_NAME?=

ifneq ($(COMPOSE_SERVICE_NAME),)
	DOCKER_SERVICE_NAME=$(COMPOSE_SERVICE_NAME)_[0-9]+_[0-9]+_$(COMPOSE_SERVICE_NAME)_[a-z0-9_]+
endif

export DOCKER_CONTAINER_SHELL?=bash

# It's like ssh for docker
define docker-exec
	@[ -n "$1" ] || (echo "Specify container name in $(@)"; exit 1)
	@$(DOCKER_EXEC) $1 $2
endef

## Open a shell in the main container
docker/exec:
	$(call assert-set,DOCKER_SERVICE_NAME)
	@$(DOCKER) ps --no-trunc | grep Up | grep -o -E "$(DOCKER_SERVICE_NAME)" | xargs -I % bash -c '</dev/tty docker exec -it % $(DOCKER_CONTAINER_SHELL)'

## Tail logs from docker-compose containers
docker/logs:
	$(call assert-set,DOCKER_SERVICE_NAME)
	@$(DOCKER) ps --no-trunc | grep Up | grep -o -E "$(DOCKER_SERVICE_NAME)" | xargs -I % bash -c 'docker logs -f %'
