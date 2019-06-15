#!/bin/sh

bundle install --deployment
bundle exec pod trunk push
