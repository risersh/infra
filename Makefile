COMPOSE_IGNORE_ORPHANS=True
export

.PHONY: cluster/manifests

setup:
	@docker network create --driver=bridge --subnet=10.67.0.0/16 --gateway=10.67.0.1 riser || true

infra/up: setup
	docker compose -f docker-compose-infra.yaml up -d

infra/down:
	docker compose -f docker-compose-infra.yaml down -v

infra/logs:
	docker compose -f docker-compose-infra.yaml logs -f

services/up:
	docker compose -f docker-compose-services.yaml up -d $(SERVICE)

services/down:
	docker compose -f docker-compose-services.yaml down $(SERVICE)

service/up:
	docker compose -f docker-compose-services.yaml up -d $(SERVICE)

service/restart:
	docker compose -f docker-compose-services.yaml restart $(SERVICE)

service/down:
	docker compose -f docker-compose-services.yaml down $(SERVICE)

service/shell:
	docker compose -f docker-compose-services.yaml exec $(SERVICE) sh

service/build:
	docker compose -f docker-compose-services.yaml build --parallel \
										--build-arg GITHUB_TOKEN=$(GITHUB_TOKEN) \
										--build-arg VITE_API_BASE_URL=https://api.dev.nvr.ai \
										--build-arg VITE_SOCKET_BASE_URL=ws://127.0.0.1:10000 \
										$(SERVICE)

service/build/all:
	docker compose -f docker-compose-services.yaml build --parallel \
										--build-arg GITHUB_TOKEN=$(GITHUB_TOKEN) \
										--build-arg VITE_API_BASE_URL=https://api.dev.nvr.ai \
										--build-arg VITE_SOCKET_BASE_URL=ws://127.0.0.1:10000

services/log:
	docker compose -f docker-compose-services.yaml logs $(SERVICE) -f

services/logs:
	docker compose -f docker-compose-services.yaml logs -f
