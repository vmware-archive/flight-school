#!/bin/bash

set -e -x

# -e make it so the entire script fails if a single command fails (which is generally desirable in CI). 
# By default, a script will keep executing if something fails. 
# he -x means that each command should be printed as it's run (also desirable in CI).

pushd flight-school
  bundle install
  bundle exec rspec
popd
