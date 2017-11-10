#!/bin/bash

set -e -x

pushd flight-school
  gem install bundler
  bundle install
  bundle exec rspec
popd
