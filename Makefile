# Variáveis
DOCKER_COMPOSE = docker-compose
SERVICES = keeper linker pulse webhook rabbitmq elasticsearch kibana postgres

# Comandos principais
.PHONY: up down clean infra only exclude build_all test $(SERVICES)

# Subir todos os serviços
up:
	@$(DOCKER_COMPOSE) up -d
	@echo "✅ Todos os serviços foram iniciados."

# Derrubar todos os serviços
down:
	@$(DOCKER_COMPOSE) down
	@echo "✅ Todos os serviços foram parados."

# Derrubar todos os serviços e remover volumes
clean:
	@$(DOCKER_COMPOSE) down -v
	@echo "✅ Todos os serviços foram parados e volumes removidos."

# Subir a infraestrutura básica
infra:
	@$(DOCKER_COMPOSE) up -d rabbitmq elasticsearch kibana postgres
	@echo "✅ Infraestrutura (RabbitMQ, Elasticsearch, Kibana, Postgres) foi iniciada."

service:
	@docker-compose -f docker-compose.services.yml up
	@echo "✅ Docker-compose de serviços foi iniciado."
	
# Subir apenas o serviço especificado
only:
	@if [ -z "$(SERVICE)" ]; then \
		echo "❌ Especifique o serviço a ser iniciado com 'make only SERVICE=<serviço>'"; \
	else \
		@$(DOCKER_COMPOSE) up -d $(SERVICE); \
		echo "✅ Apenas o serviço '$(SERVICE)' foi iniciado."; \
	fi

# Build em subdiretórios
build_all:
	@PARENT_DIR=$$(dirname $$(pwd)); \
	for subdir in $(SERVICES); do \
		TARGET_DIR=$$PARENT_DIR/$$subdir; \
		if [ -d $$TARGET_DIR ]; then \
			echo "🔨 Building in $$TARGET_DIR"; \
			$(MAKE) -C $$TARGET_DIR build || exit 1; \
		else \
			echo "⚠️  Directory $$TARGET_DIR not found! Skipping..."; \
		fi; \
	done
	@echo "✅ Build concluído para todos os subdiretórios."
