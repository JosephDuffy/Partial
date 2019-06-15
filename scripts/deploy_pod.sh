#!/bin/sh

gem install bundler
bundle install --deployment
bundle exec pod trunk push
