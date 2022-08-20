#!/bin/sh

set -eu -o pipefail

bundle exec rails db:setup || true
bundle exec rails db:migrate

exec "$@"
