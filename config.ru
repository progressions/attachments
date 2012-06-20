require "rubygems"
require "bundler/setup"
require "sinatra"
require "haml"
require "app"
 
set :run, false
set :raise_errors, true

Bundler.require 

run Sinatra::Application

map '/assets' do
    environment = Sprockets::Environment.new
    environment.append_path 'assets/javascripts'
    environment.append_path 'assets/stylesheets'
    environment.append_path 'vendor/bootstrap-sass/vendor/assets/javascripts'
    environment.append_path 'vendor/bootstrap-sass/vendor/assets/images'
    environment.append_path 'vendor/bootstrap-sass/vendor/assets/stylesheets'

    Sprockets::Helpers.configure do |config|
      config.environment = environment
      config.prefix      = '/assets'
      config.digest      = false
    end

    run environment
end
