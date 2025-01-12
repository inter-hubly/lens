# Variáveis
DOCKER_COMPOSE = docker-compose -f docker-compose.yml

# Comandos
.PHONY: up down clean focus keeper linker pulse webhook rabbitmq elasticsearch kibana postgres all_build

# Subir todos os serviços
up:
	@$(DOCKER_COMPOSE) up -d
	@echo "Todos os serviços foram iniciados."

# Descer todos os serviços
down:
	@$(DOCKER_COMPOSE) down
	@echo "Todos os serviços foram parados."

# Descer todos os serviços e deletar volumes
clean:
	@$(DOCKER_COMPOSE) down -v
	@echo "Todos os serviços foram parados e volumes removidos."

# Subir serviços individualmente
keeper:
	@$(DOCKER_COMPOSE) up -d keeper
	@echo "Serviço 'keeper' foi iniciado."

linker:
	@$(DOCKER_COMPOSE) up -d linker
	@echo "Serviço 'linker' foi iniciado."

pulse:
	@$(DOCKER_COMPOSE) up -d pulse
	@echo "Serviço 'pulse' foi iniciado."

webhook:
	@$(DOCKER_COMPOSE) up -d webhook
	@echo "Serviço 'webhook' foi iniciado."

focus:
	@$(DOCKER_COMPOSE) up -d focus
	@echo "Serviço 'focus' foi iniciado."
	
rabbitmq:
	@$(DOCKER_COMPOSE) up -d rabbitmq
	@echo "Serviço 'rabbitmq' foi iniciado."

elasticsearch:
	@$(DOCKER_COMPOSE) up -d elasticsearch
	@echo "Serviço 'elasticsearch' foi iniciado."

kibana:
	@$(DOCKER_COMPOSE) up -d kibana
	@echo "Serviço 'kibana' foi iniciado."

postgres:
	@$(DOCKER_COMPOSE) up -d postgres
	@echo "Serviço 'postgres' foi iniciado."

infra:
	@$(DOCKER_COMPOSE) up -d rabbitmq elasticsearch kibana postgres
	@echo "Infraestrutura (RabbitMQ, Elasticsearch, Kibana, Postgres) foi iniciada."

# Subdiretórios a serem processados após voltar uma pasta
SUBDIRS = keeper linker pulse webhook focus
# Regra para encontrar o diretório pai e executar make build
all_build:
	@PARENT_DIR=$$(dirname $$(pwd)); \
	for subdir in $(SUBDIRS); do \
		TARGET_DIR=$$PARENT_DIR/$$subdir; \
		if [ -d $$TARGET_DIR ]; then \
			echo "Building in $$TARGET_DIR"; \
			$(MAKE) -C $$TARGET_DIR build || exit 1; \
		else \
			echo "Directory $$TARGET_DIR not found! Skipping..."; \
		fi; \
	done
