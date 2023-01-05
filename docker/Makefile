bundle-install:
	docker-compose run --rm api bundle install --without production

bundle-update:
	docker-compose run --rm api bundle update

db-migrate:
	docker-compose run --rm api bundle exec rails db:migrate RAILS_ENV=development

seed_fu:
	docker-compose run --rm api bundle exec rails db:seed_fu

rubocop:
	docker-compose run --rm api bundle exec rubocop -a

rspec:
	docker-compose run --rm api bundle exec rspec

routes:
	docker-compose run --rm api bin/rails routes

console:
	docker-compose run --rm api bin/rails c
	
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
