DOCKER_COMPOSE = $(shell which docker-compose)
DOCKER_MONITOR_TABLE ?= 'table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}'

export COMPOSE_SERVICE_NAME?=svc
export COMPOSE_FILE?=docker/docker-compose.yaml
export COMPOSE_FLAGS?=
COMPOSE_PROJECT_NAME:=$(COMPOSE_SERVICE_NAME)_$(SHELL_UID)
COMPOSE_FLAGS:=-p $(COMPOSE_PROJECT_NAME) -f $(COMPOSE_FILE) $(COMPOSE_FLAGS)

$(COMPOSE_FILE):
	@echo "Compose file not found! ($(COMPOSE_FILE))"
	@exit 1

compose/debug: $(COMPOSE_FILE)
	$(call print-var,SHELL_UID)
	$(call print-var,COMPOSE_SERVICE_NAME)
	$(call print-var,COMPOSE_PROJECT_NAME)
	$(call print-var,COMPOSE_FLAGS)
	$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) --version
.PHONY: compose/debug

## Start local dev environment (daemonized)
compose/up: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) up -d
.PHONY: compose/up

## Stop local dev environment
compose/down: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) down
.PHONY: compose/down

## Restart local dev environment
compose/restart: compose/down compose/up
.PHONY: compose/restart

## Purge local dev environment
compose/purge: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) down -v
.PHONY: compose/purge

## Rebuild custom containers for local dev environment
compose/rebuild: compose/down compose/build compose/up
.PHONY: compose/rebuild

## Tail logs from docker-compose containers
compose/logs: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) logs -f
.PHONY: compose/logs

## Build local dev environment
compose/build: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) build
.PHONY: compose/build

## Show default compose ps
compose/ps: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) ps
.PHONY: compose/ps

## Show containers resource usage
compose/monitor: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE) --no-stream
.PHONY: compose/monitor

## Monitor in time containers resource usage
compose/monitor/follow: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) ps -q | tr '\n' ' ' | docker stats --format $(DOCKER_MONITOR_TABLE)
.PHONY: compose/monitor/follow

## Show top for containers
compose/top: $(COMPOSE_FILE)
	@$(DOCKER_COMPOSE) $(COMPOSE_FLAGS) top
.PHONY: compose/top
