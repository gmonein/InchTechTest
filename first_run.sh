docker-compose run --entrypoint "rails webpacker:install" app
docker-compose run --entrypoint "rails db:create" app
docker-compose run --entrypoint "rails db:migrate " app
