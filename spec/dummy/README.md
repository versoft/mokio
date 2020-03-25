# Spec Dummy App
App used for testing and run Mokio gem.

### How to configure:
1. Copy `spec/dummy/.sample.env` to `spec/dummy/.env`
2. Update `spec/dummy/.env` - "development" and "test" database should be different.
3. Run commands to create database, run migrations and seed data in `spec/dummy`:
```
bundle install
yarn install
rails db:create
rails mokio:install:migrations
rails db:migrate
rails mokio:install
```
4. Create test database:
```
RAILS_ENV=test rails db:create
RAILS_ENV=test rails db:migrate
```

**ATTENTION!** After fetch changes always check are there any new migrations:
```
rails mokio:install:migrations
rails db:migrate
RAILS_ENV=test rails db:migrate
```

Run tests from main Mokio App: `rspec`
