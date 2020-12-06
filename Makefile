DOCKER = docker-compose -f docker/docker-compose.yml
PHP_EXEC = $(DOCKER) exec phpfpm
COMPOSER = $(PHP_EXEC) composer
SYMFONY = $(PHP_EXEC) bin/console

include .env
export

up: start composer-install cache-warmup load-database-backup

start:
	$(DOCKER) up -d

build:
	$(DOCKER) build --pull --progress auto --force-rm

pull:
	$(DOCKER) pull

logs:
	$(DOCKER) logs phpfpm

stop:
	$(DOCKER) stop

nodev: backup-database
	$(DOCKER) down

enter:
	$(PHP_EXEC) bash

composer-install:
	@if [ -f composer.json ]; then $(COMPOSER) install; else echo "No 'composer.json' file found"; fi;

composer-update:
	@if [ -f composer.json ]; then $(COMPOSER) update; else echo "No 'composer.json' file found"; fi;

cache-clear:
	@if [ -f composer.json ]; then $(SYMFONY) cache:clear; else echo "No Symfony console found"; fi;

cache-warmup:
	@if [ -f composer.json ]; then $(SYMFONY) cache:warmup; else echo "No Symfony console found"; fi;

backup-database:
	@echo "Backing up dev database to 'docker/database/backup.sql'"
	@mkdir -p docker/database
	@${DOCKER} exec -T -e MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysql /usr/bin/mysqldump -u root ${MYSQL_DATABASE} > docker/database/backup.sql

load-database-backup:
	@until ${DOCKER} exec -T -e MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysql mysqladmin status -h localhost -u root &> /dev/null; do echo "Waiting for mysql to accept connections..."; sleep 10; done
	@echo "Loading dev database from 'docker/database/backup.sql'"
	@cat docker/database/backup.sql 2>/dev/null | ${DOCKER} exec -T -e MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysql /usr/bin/mysql -u root ${MYSQL_DATABASE}