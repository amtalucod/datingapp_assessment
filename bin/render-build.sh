#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
#bundle exec rails db:reset
#bundle exec rails db:seed
bundle exec rails db:migrate

