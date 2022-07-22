# README

Digi-test is an test-task application.

<img width="1786" alt="image" src="https://user-images.githubusercontent.com/36458127/180449526-46009608-5073-43c3-abee-e37aad628b4a.png">

## Main system dependencies

- Ruby 3.1.2 (Rails 7.0+)
- PostgreSQL 9.3+

## Local deployment

- Install system dependencies
- Ask credentials keys (development.key, test.key) from repository maintainers and copy them to /config/credentials/*
- Setup new user via posgres (See Setup PostgreSQL users for development)
- Run `bundle exec rails db:create` to create a new database (could be replaced with `bundle exec rails db:setup`)
- Run `bundle exec rails db:migrate` to run all the migrations (could be replaced with `bundle exec rails db:setup`)
- Run `bundle exec rails db:seed` to run all the migrations (could be replaced with `bundle exec rails db:setup`)
- Run `bundle install` to setup all the needed gems
- Run `lefthook install` to enable linters running on pre-push, pre-commit hooks
- Run `rails s` to run the appliction

## Setup PostgreSQL users for development/test

- Run `psql postgres`
- Create database with name of your user (listed as db.username in Rails credentials);
    - `create database digi;`
- Create user (listed as db.username and db.password in Rails credentials);
    - `create user digi with encrypted password 'super-secret-password-local';`
- Add ability to manage databases to created user
    - `ALTER USER digi CREATEDB;`

## Linting

- Configuration is placed in `lefthook.yml.` in the root of project
- Lint all the project with `lefthook run pre-commit' and 'lefthook run pre-push`

## Tests run

- Run feature and unit tests `bundle exec rspec`
