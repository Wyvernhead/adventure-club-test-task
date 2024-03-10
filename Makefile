DOCKER_COMPOSE=docker compose

.DEFAULT_GOAL := help
##help: List available tasks on this project
help:
	@echo ""
	@echo "These are the available commands"
	@echo ""
	@grep -E '\#\#[a-zA-Z\.\-]+:.*$$' $(MAKEFILE_LIST) \
		| tr -d '##' \
		| awk 'BEGIN {FS = ": "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}' \


build:
	$(DOCKER_COMPOSE) build --no-cache
.PHONY: build

prepare:
	chmod +x server/php/start.sh
	$(DOCKER_COMPOSE) exec php server/php/start.sh
.PHONY: prepare

up:
	$(DOCKER_COMPOSE) up -d
.PHONY: up

start: build up prepare
.PHONY: start

stop:
	$(DOCKER_COMPOSE) kill
.PHONY: stop
