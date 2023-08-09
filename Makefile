create-project:
	mkdir -p src
	docker compose -f docker-compose.yml  --env-file ./src/.env build
	docker compose -f docker-compose.yml --env-file ./src/.env up -d
	docker compose -f docker-compose.yml --env-file ./src/.env exec app composer create-project --prefer-dist laravel/laravel .
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan key:generate
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan storage:link
	docker compose -f docker-compose.yml --env-file ./src/.env exec app chmod -R 777 storage bootstrap/cache
	@make fresh


build:
	docker compose -f docker-compose.yml --env-file ./src/.env build

build-prod:
	docker compose -f docker-compose.prod.yml --env-file ./src/.env build

up:
	docker compose -f docker-compose.yml --env-file ./src/.env up -d
up-prod:
	docker compose -f docker-compose.prod.yml --env-file ./src/.env up -d

up-b:
	@make build
	docker compose -f docker-compose.yml --env-file ./src/.env up -d

up-b-prod:
	@make build-prod
	docker compose -f docker-compose.prod.yml --env-file ./src/.env up -d

prod-init:
	@make up-b-prod
	@make app-install-prod




down:
	docker compose -f docker-compose.yml --env-file ./src/.env down --remove-orphans

down-v:
	docker compose -f docker-compose.yml --env-file ./src/.env down --remove-orphans --volumes

restart:
	@make down
	@make up



destroy:
	docker compose -f docker-compose.yml --env-file ./src/.env  down --rmi all --volumes --remove-orphans


fresh:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan migrate:fresh --seed

app:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app bash

app-install:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app composer install
app-install-prod:
	docker compose -f docker-compose.prod.yml --env-file ./src/.env exec app composer install




ps:
	docker compose -f docker-compose.yml --env-file ./src/.env ps
logs:
	docker compose -f docker-compose.yml --env-file ./src/.env logs
logs-watch:
	docker compose -f docker-compose.yml --env-file ./src/.env logs --follow
log-web:
	docker compose -f docker-compose.yml --env-file ./src/.env logs web
log-web-watch:
	docker compose -f docker-compose.yml --env-file ./src/.env logs --follow web
log-app:
	docker compose -f docker-compose.yml --env-file ./src/.env logs app
log-app-watch:
	docker compose -f docker-compose.yml --env-file ./src/.env logs --follow app
log-db:
	docker compose -f docker-compose.yml --env-file ./src/.env logs db
log-db-watch:
	docker compose -f docker-compose.yml --env-file ./src/.env logs --follow db
web:
	docker compose -f docker-compose.yml --env-file ./src/.env exec web bash
app:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app bash
migrate:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan migrate
fresh:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan migrate:fresh --seed
seed:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan db:seed
dacapo:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan dacapo
rollback-test:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan migrate:fresh
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan migrate:refresh
tinker:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan tinker
test:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan test
optimize:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan optimize
optimize-clear:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan optimize:clear
cache:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app composer dump-autoload -o
	@make optimize
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan event:cache
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan view:cache
cache-clear:
	docker compose -f docker-compose.yml --env-file ./src/.env exec app composer clear-cache
	@make optimize-clear
	docker compose -f docker-compose.yml --env-file ./src/.env exec app php artisan event:clear
db:
	docker compose -f docker-compose.yml --env-file ./src/.env exec db bash
sql:
	docker compose -f docker-compose.yml --env-file ./src/.env exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD'
redis:
	docker compose -f docker-compose.yml --env-file ./src/.env exec redis redis-cli
