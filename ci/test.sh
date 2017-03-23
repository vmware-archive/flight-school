#!/bin/bash

echo 'Test stuff'
set -e -x

pushd flight-school
  bundle install
  bundle exec rspec
popd
