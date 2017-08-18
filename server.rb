# encoding: utf-8

require './config/boot'

## -- for thin web server use:
## Rack::Handler::Thin.run StarterApp.new, :Port => 9292

Rack::Handler::WEBrick.run StarterApp.new, :Port => 9292
