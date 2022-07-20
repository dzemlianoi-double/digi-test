#<--rubocop/md--># README
#<--rubocop/md-->
#<--rubocop/md-->Digi-test is an test-task application.
#<--rubocop/md-->
#<--rubocop/md-->## Main system dependencies
#<--rubocop/md-->
#<--rubocop/md-->- Ruby 3.1.2 (Rails 7.0+)
#<--rubocop/md-->- PostgreSQL 9.3+
#<--rubocop/md-->
#<--rubocop/md-->## Local deployment
#<--rubocop/md-->
#<--rubocop/md-->- Install system dependencies
#<--rubocop/md-->- Ask credentials keys (development.key, test.key) from repository maintainers and copy them to /config/credentials/*
#<--rubocop/md-->- Setup new user via posgres (See Setup PostgreSQL users for development)
#<--rubocop/md-->- Run `bundle exec rails db:create` to create a new database (could be replaced with `bundle exec rails db:setup`)
#<--rubocop/md-->- Run `bundle exec rails db:migrate` to run all the migrations (could be replaced with `bundle exec rails db:setup`)
#<--rubocop/md-->- Run `bundle exec rails db:seed` to run all the migrations (could be replaced with `bundle exec rails db:setup`)
#<--rubocop/md-->- Run `bundle install` to setup all the needed gems
#<--rubocop/md-->- Run `lefthook install` to enable linters running on pre-push, pre-commit hooks
#<--rubocop/md-->- Run `rails s` to run the appliction
#<--rubocop/md-->
#<--rubocop/md-->## Setup PostgreSQL users for development/test
#<--rubocop/md-->
#<--rubocop/md-->- Run `psql postgres`
#<--rubocop/md-->- Create database with name of your user (listed as db.username in Rails credentials);
#<--rubocop/md-->    - `create database digi;`
#<--rubocop/md-->- Create user (listed as db.username and db.password in Rails credentials);
#<--rubocop/md-->    - `create user digi with encrypted password 'super-secret-password-local';`
#<--rubocop/md-->- Add ability to manage databases to created user
#<--rubocop/md-->    - `ALTER USER digi CREATEDB;`
#<--rubocop/md-->
#<--rubocop/md-->## Linting
#<--rubocop/md-->
#<--rubocop/md-->- Configuration is placed in `lefthook.yml.` in the root of project
#<--rubocop/md-->- Lint all the project with `lefthook run pre-commit' and 'lefthook run pre-push`
