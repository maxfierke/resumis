# Resumis

Resumis is a personal homepage & resume management application aimed at developers involved in open source. It is the logical continuation of an application I wrote in Flask to manage my own personal site. It is also my final project for INET 3350 (Special Topics in IT Infrastruture: Ruby and Rails) at the University of Minnesota taught by [John Norman](https://github.com/jgn).

## Requirements
* Ruby 2.1+
* Rails 4.2
* PostgreSQL 9.3+ with development dependencies
* Node.js or another supported execjs runtime. I assume node.js. If you prefer `therubyracer`, uncomment it in the Gemfile.
* `imagemagick`
* Bare domain name for multi-tenancy mode. In dev, you'll want to use lvh.me. I personally setup all my rails apps through [Anvil](http://anvilformac.com/) and [Pow](http://pow.cx/), which handles setting them up under local *.dev domains.
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

### Configuration

Resumis-specific configuration can be done either through the `config/initializers/resumis.rb` initializer file, or through a some environmental variables.

* `SECRET_KEY_BASE` - Generate a value via `rake secret`.
* `RESUMIS_DEVISE_SECRET` - Generate a value via `rake secret`.
* `RESUMIS_MAIL_SENDER` - `From:` address for emails sent by Resumis (password resets, confirmations, etc.)
* `RESUMIS_CANONICAL_HOST` - Bare domain of the resumis installation for multi-tenancy mode. Canonical hostname for single-tenancy mode.
* `RESUMIS_TENANCY_MODE` - Can be `single` or `multi`. **This is not easily changed later**

## Deployment

### Capistrano

Deployment can be done via Capistrano. Capistrano has been setup with some sensible defaults, but you'll need to create a capistrano stage to configure things further (hosts, etc):

```
$ bundle exec cap install STAGES=staging,production
```

This will create `config/deploy/staging.rb` and `config/deploy/production.rb`. Modify them as needed.

### Amazon OpsWorks

Resumis deploys somewhat easily on Amazon OpsWorks (with some caveats in the initial setup with PostgreSQL) and has hooks built in for asset compiliation on deploy.

[AWSBlog has an article on deploying Rails apps on OpsWorks](http://ruby.awsblog.com/post/Tx7FQMT084INCR/Deploying-Ruby-on-Rails-Applications-to-AWS-OpsWorks)

Some general hints:

* Create a standard Ruby on Rails OpsWorks stack with at least Ruby 2.1+, and nginx with Unicorn.
* Create an OpsWorks app called "resumis". Set your data source. I'm using a PostgreSQL RDS instance.
* Setup to deploy from either this repository, or your personal fork, etc.
* Setup environmental variables as required. (see Configuration section above)
* Add this to the Custom JSON in your stack settings

  ```
  {
    "deploy": {
      "resumis": {
        "database": {
          "adapter": "postgresql"
        }
      }
    }
  }
  ```


## LICENSE

Apache License 2.0. See LICENSE
