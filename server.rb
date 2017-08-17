# encoding: utf-8

require './config/boot'

## Rack::Handler::Thin.run StarterApp.new, :Port => 9292

Rack::Handler::WEBrick.run StarterApp.new, :Port => 9292
