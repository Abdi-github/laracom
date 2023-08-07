create-project:
	mkdir -p src
	docker compose --env-file ./src/.env build
	docker compose --env-file ./src/.env up -d
	docker compose --env-file ./src/.env exec app composer create-project --prefer-dist laravel/laravel .
	docker compose --env-file ./src/.env exec app php artisan key:generate
	docker compose --env-file ./src/.env exec app php artisan storage:link
	docker compose --env-file ./src/.env exec app chmod -R 777 storage bootstrap/cache
	@make fresh


build:
	docker compose --env-file ./src/.env build

up:
	docker compose --env-file ./src/.env up -d

up-b:
	@make build
	docker compose --env-file ./src/.env up -d

down:
	docker compose --env-file ./src/.env down --remove-orphans

down-v:
	docker compose --env-file ./src/.env down --remove-orphans --volumes

restart:
	@make down
	@make up



destroy:
	docker-compose --env-file ./src/.env  down --rmi all --volumes --remove-orphans


fresh:
	docker compose --env-file ./src/.env exec app php artisan migrate:fresh --seed

app:
	docker compose --env-file ./src/.env exec app bash

app-live:
	docker-compose --env-file ./src/.env  run --rm --publish 5173:5173 app npm run dev -- --host


ps:
	docker compose --env-file ./src/.env ps
logs:
	docker compose --env-file ./src/.env logs
logs-watch:
	docker compose --env-file ./src/.env logs --follow
log-web:
	docker compose --env-file ./src/.env logs web
log-web-watch:
	docker compose --env-file ./src/.env logs --follow web
log-app:
	docker compose --env-file ./src/.env logs app
log-app-watch:
	docker compose --env-file ./src/.env logs --follow app
log-db:
	docker compose --env-file ./src/.env logs db
log-db-watch:
	docker compose --env-file ./src/.env logs --follow db
web:
	docker compose --env-file ./src/.env exec web bash
app:
	docker compose --env-file ./src/.env exec app bash
migrate:
	docker compose --env-file ./src/.env exec app php artisan migrate
fresh:
	docker compose --env-file ./src/.env exec app php artisan migrate:fresh --seed
seed:
	docker compose --env-file ./src/.env exec app php artisan db:seed
dacapo:
	docker compose --env-file ./src/.env exec app php artisan dacapo
rollback-test:
	docker compose --env-file ./src/.env exec app php artisan migrate:fresh
	docker compose --env-file ./src/.env exec app php artisan migrate:refresh
tinker:
	docker compose --env-file ./src/.env exec app php artisan tinker
test:
	docker compose --env-file ./src/.env exec app php artisan test
optimize:
	docker compose --env-file ./src/.env exec app php artisan optimize
optimize-clear:
	docker compose --env-file ./src/.env exec app php artisan optimize:clear
cache:
	docker compose --env-file ./src/.env exec app composer dump-autoload -o
	@make optimize
	docker compose --env-file ./src/.env exec app php artisan event:cache
	docker compose --env-file ./src/.env exec app php artisan view:cache
cache-clear:
	docker compose --env-file ./src/.env exec app composer clear-cache
	@make optimize-clear
	docker compose --env-file ./src/.env exec app php artisan event:clear
db:
	docker compose --env-file ./src/.env exec db bash
sql:
	docker compose --env-file ./src/.env exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD'
redis:
	docker compose --env-file ./src/.env exec redis redis-cli
