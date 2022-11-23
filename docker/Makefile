bundle-install:
	docker-compose run --rm api bundle install --without production

bundle-update:
	docker-compose run --rm api bundle update

db-migrate:
	docker-compose run --rm api bundle exec rails db:migrate RAILS_ENV=development

test:
	docker-compose run --rm api bundle exec rails test

build:
	docker-compose build

up:
	docker-compose up -d

stop:
	docker-compose stop

ps:
	docker-compose ps -a

logs:
	docker-compose logs -f api

remove-credentials:
	docker-compose run --rm api rm config/credentials.yml.enc

create-credentials:
	docker-compose run --rm -e EDITOR=vi api bundle exec rails credentials:edit
