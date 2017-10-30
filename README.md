# README

A simple, restful api service allowing search and creation of users.

Prerequisites:

* Ruby 2.3 >=

* Rails 5.0 >=

* Java installed (for solr)

* `brew install redis`

Running the app:
*  update database.yml with credentials
*  copy .env.sample to .env and update
* `rails db:create`
* `rails db:migrate`

* `foreman start`

Running tests:
* `rake`
