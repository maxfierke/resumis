# Resumis

Resumis is a personal homepage & resume management application aimed at developers involved in open source. It is the logical continuation of an application I wrote in Flask to manage my own personal site. It is also my final project for INET 3350 (Special Topics in IT Infrastruture: Ruby and Rails) at the University of Minnesota taught by [John Norman](https://github.com/jgn).

## Requirements
* Ruby 2.1.x
* Rails 4.1
* PostgreSQL 9.x
* Bare domain name. In dev, you'll want to use lvh.me. I personally setup all my rails apps through [Anvil](http://anvilformac.com/) and [Pow](http://pow.cx/), which handles setting them up under local *.dev domains.
* SMTP server (Production is configured to use SendGrid with credentials set by environmental variables `SENDGRID_USERNAME`, `SENDGRID_PASSWORD`, and `SENDGRID_DOMAIN`). It's only used by Devise for things like password resets, or confirmation emails. This is not a hard dependency and certainly not needed for development.

and others. See [Gemfile](Gemfile).

## Installation & Setup

* Clone the repo

  ```
  $ git clone git@github.com:maxfierke/resumis.git && cd resumis
  ```

* Install dependencies with Bundler

  ```
  $ bundle install
  ```

* Create the database, run the migrations

  ```
  $ rake db:create db:migrate
  ```

* Run the app in WEBrick

  ```
  $ rails s
  ```

* Go to [lvh.me](http://lvm.me) and setup your first tenant (you!). Note that lvh.me is necessary on development, since this is a multi-tenant application dependent on subdomains. lvh.me is a domain setup to point to localhost (127.0.0.1).

## Deployment

Deployment can be done via Capistrano. Capistrano has been setup with some sensible defaults, but you'll need to create a capistrano stage to configure things further (hosts, etc):

```
$ bundle exec cap install STAGES=staging,production
```

This will create `config/deploy/staging.rb` and `config/deploy/production.rb`. Modify them as needed.

## LICENSE

Apache License 2.0. See LICENSE
