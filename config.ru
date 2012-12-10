require "rubygems"
require "bundler/setup"
require "sinatra"
require "coffee-script"
require "haml"
require "app"
 
set :run, false
set :raise_errors, true

set :root, File.expand_path('../', __FILE__)

Bundler.require 

run Sinatra::Application

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'

  Sprockets::Helpers.configure do |config|
    config.environment = environment
    config.prefix      = '/assets'
    config.digest      = false
  end

  run environment
end
