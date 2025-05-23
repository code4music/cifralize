compose = docker compose -f build/docker-compose.yaml

.PHONY: build
build:
	$(compose) build

.PHONY: up
up:
	$(compose) up

.PHONY: logs
logs:
	$(compose) logs -f --tail=100

.PHONY: db
db:
	$(compose) run --rm app rails db:drop db:create db:migrate db:test:prepare db:seed

.PHONY: bundle
bundle:
	$(compose) run --rm app bundle

.PHONY: bash
bash:
	$(compose) run --rm app /bin/bash

.PHONY: console
console:
	$(compose) run --rm app rails console

.PHONY: lint
lint:
	$(compose) run --rm app rubocop -A

.PHONY: test
test:
	$(compose) run --rm app rails test

.PHONY: stop
stop:
	$(compose) stop

.PHONY: clean
clean:
	$(compose) down --remove-orphans --volumes

.PHONY: permission
permission:
	sudo chown -R $(USER):$(USER) .

.PHONY: production
production:
	git pull
	docker compose --env-file .env -f build/docker-compose-production.yaml stop
	docker compose --env-file .env -f build/docker-compose-production.yaml build
	docker compose --env-file .env -f build/docker-compose-production.yaml run app bundle exec rails assets:precompile
	docker compose --env-file .env -f build/docker-compose-production.yaml run app rails db:migrate
	docker compose --env-file .env -f build/docker-compose-production.yaml up -d

.PHONY: pull
pull:
	git pull
	docker compose --env-file .env -f build/docker-compose-production.yaml stop app
	docker compose --env-file .env -f build/docker-compose-production.yaml up -d app

.PHONY: pg-dump
pg-dump:
	docker compose --env-file .env -f build/docker-compose-production.yaml run --rm pg-dump /bin/bash

.PHONY: do-backup-images
do-backup-images:
	docker compose --env-file .env -f build/docker-compose-production.yaml run --rm do-backup-images /bin/bash

.PHONY: pre-dumps
pre-dumps:
	mkdir db/dumps
	touch db/dumps/last.sql
