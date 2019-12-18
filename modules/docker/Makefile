DOCKER:= $(shell which docker 2>/dev/null)
DOCKER_RUN ?= docker run -i --rm --network=$(DOCKER_NETWORK)
DOCKER_EXEC ?= $(DOCKER) exec -it

export CONTAINER_SHELL ?= bash

# It's like ssh for docker
define docker-exec
	@[ -n "$1" ] || (echo "Specify container name in $(@)"; exit 1)
	@$(DOCKER_EXEC) $1 $2
endef

## Open a shell in the main container
docker/exec:
	@$(DOCKER) ps --no-trunc | grep Up | grep -o -E "$(COMPOSE_SERVICE_NAME)_[0-9]+_[0-9]+_$(COMPOSE_SERVICE_NAME)_[a-z0-9_]+" | xargs -I % bash -c '</dev/tty docker exec -it % $(CONTAINER_SHELL)'

## Tail logs from docker-compose containers
docker/logs:
	@$(DOCKER) ps --no-trunc | grep Up | grep -o -E "$(COMPOSE_SERVICE_NAME)_[0-9]+_[0-9]+_$(COMPOSE_SERVICE_NAME)_[a-z0-9_]+" | xargs -I % bash -c 'docker logs -f %'
