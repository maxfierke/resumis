# Resumis

Resumis is _Esperanto_ for "summarized". It's also a platform for managing your personal internet homepage presence and advertising yourself to the world.

## Other People
### Requirements
* Ruby 2.1+
* Rails 4.2
* PostgreSQL 9.3+ with development dependencies
* Node.js or another supported execjs runtime. I assume node.js. If you prefer `therubyracer`, uncomment it in the Gemfile.
* `wkhtmltopdf`. 0.12.x+ recommended. 0.9.9.x has issues with the resume layout. Will use either a binary specified by `WKHTMLTOPDF_PATH` (defaults to `/usr/local/bin/wkhtmltopdf`)
* `imagemagick`
* `ffmpeg` with h264 and libvpx (webm) support
* Redis for Sidekiq, but you can sub this out for Resque, `delayed_job`, and other queues supported by ActiveJob and `carrierwave_backgrounder`.
* Bare domain name for multi-tenancy mode. In dev, you'll want to use lvh.me or a locally resolving domain name with support for wildcard subdomains. I personally setup all my rails apps through [Anvil](http://anvilformac.com/) and [Pow](http://pow.cx/), which handles setting them up under local *.dev domains.
* SMTP server (Production is configured to use SendGrid with credentials set by environmental variables `SENDGRID_USERNAME`, `SENDGRID_PASSWORD`, and `SENDGRID_DOMAIN`). It's only used by Devise for things like password resets, or confirmation emails. This is not a hard dependency and certainly not needed for development.

and others. See [Gemfile](Gemfile).

### Installation & Setup

* Clone the repo

  ```
  $ git clone git@github.com:maxfierke/resumis.git && cd resumis
  ```

* Install dependencies with Bundler

  ```
  $ bundle install
  ```
* See [Configuration](#Configuration) below and set any needed environment variables. In development, put them in `.env`.

* Create the database, run the migrations

  ```
  $ rake db:create db:migrate
  ```

* Run the app using [foreman](https://github.com/ddollar/foreman)

  ```
  $ foreman start
  ```

* Go to [lvh.me](http://lvm.me) (or whatever locally-resolving domain you're using) and setup your first tenant (you!). Note that lvh.me (or another locally resolving domain with wildcard subdomains) is necessary on development in multi-tenancy mode.

#### Configuration

Resumis-specific configuration can be done either through the `config/initializers/resumis.rb` initializer file, or through a some environmental variables.

* `SECRET_KEY_BASE` - Generate a value via `rake secret`.
* `RESUMIS_DEVISE_SECRET` - Generate a value via `rake secret`.
* `RESUMIS_MAIL_SENDER` - `From:` address for emails sent by Resumis (password resets, confirmations, etc.)
* `RESUMIS_CANONICAL_HOST` - Bare domain of the resumis installation for multi-tenancy mode. Canonical hostname for single-tenancy mode.
* `RESUMIS_TENANCY_MODE` - Can be `single` or `multi`. **This is not easily changed later**


## LICENSE

Apache License 2.0. See LICENSE
