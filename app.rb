require 'sinatra/base'
require 'sinatra/config_file'

require 'twilio-ruby'

require_relative 'helpers/data_mapper_setup'
require_relative 'models/employee'
require_relative 'lib/searcher'
require_relative 'routes/employee'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

class EmployeeDirectoryApp < Sinatra::Application
  register Sinatra::ConfigFile
  config_file 'config/app.yml.erb'
  Helpers::DataMapperSetup.setup(settings.database_url)

  register Routes::Employee

  run! if app_file == $PROGRAM_NAME
end
