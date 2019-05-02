DOCKER_COMPOSE = $(shell which docker-compose)
DOCKER_MONITOR_TABLE ?= 'table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'

export COMPOSE_FILE ?= docker/docker-compose.yaml

$(COMPOSE_FILE):
	@echo "Compose file not found! ($(COMPOSE_FILE))"
	@exit 1

compose/debug: $(COMPOSE_FILE)
	@echo "SERVICE_NAME=$(SERVICE_NAME)"
	@echo "COMPOSE_FILE=$(COMPOSE_FILE)"
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) --version

## Start local dev environment (daemonized)
compose/up: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) up -d

## Stop local dev environment
compose/down: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) down

## Restart local dev environment
compose/restart: compose/down compose/up

## Purge local dev environment
compose/purge: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) down -v

## Rebuild custom containers for local dev environment
compose/rebuild: compose/down compose/build compose/up

## Tail logs from docker-compose containers
compose/logs: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) logs -f

## Build local dev environment
compose/build: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) build

## Show default compose ps
compose/ps: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) ps

## Show containers resource usage
compose/monitor: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE) --no-stream

## Monitor in time containers resource usage
compose/monitor/follow: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE)

## Show top for containers
compose/top: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) -p "$(SERVICE_NAME)_$(shell ls -id . | cut -d' ' -f1)_$(shell id -u)" -f $(COMPOSE_FILE) top
