DOCKER_COMPOSE = $(shell which docker-compose)
DOCKER_MONITOR_TABLE ?= 'table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'

SHELL_UID := $(shell ls -id . | cut -d' ' -f1)_$(shell id -u)
export COMPOSE_SERVICE_NAME?=svc

export COMPOSE_FILE?=docker/docker-compose.yaml
export COMPOSE_DEV_FILE?=
COMPOSE_FILE_ARGS=-f $(COMPOSE_FILE) -f $(COMPOSE_DEV_FILE)
ifndef COMPOSE_DEV_FILE
	COMPOSE_FILE_ARGS=-f $(COMPOSE_FILE)
endif

COMPOSE_PROJECT_NAME:=$(COMPOSE_SERVICE_NAME)_$(SHELL_UID)

$(COMPOSE_FILE):
	@echo "Compose file not found! ($(COMPOSE_FILE))"
	@exit 1

compose/debug: $(COMPOSE_FILE)
	@echo "COMPOSE_SERVICE_NAME=$(COMPOSE_SERVICE_NAME)"
	@echo "COMPOSE_FILE=$(COMPOSE_FILE)"
	@echo "COMPOSE_DEV_FILE=$(COMPOSE_DEV_FILE)"
	$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) --version

## Start local dev environment (daemonized)
compose/up: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) up -d

## Stop local dev environment
compose/down: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) down

## Restart local dev environment
compose/restart: compose/down compose/up

## Purge local dev environment
compose/purge: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) down -v

## Rebuild custom containers for local dev environment
compose/rebuild: compose/down compose/build compose/up

## Tail logs from docker-compose containers
compose/logs: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) logs -f

## Build local dev environment
compose/build: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) build

## Show default compose ps
compose/ps: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) ps

## Show containers resource usage
compose/monitor: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE) --no-stream

## Monitor in time containers resource usage
compose/monitor/follow: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE)

## Show top for containers
compose/top: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p $(COMPOSE_PROJECT_NAME) $(COMPOSE_FILE_ARGS) top
