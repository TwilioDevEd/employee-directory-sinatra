require 'sinatra'
require 'data_mapper'

class EmployeeDirectoryApp < Sinatra::Application

  DataMapper.setup(:default,
                   "sqlite3://#{Dir.pwd}/employee_dir_test_database.db")

  class Employee
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :image_url, String
    property :email, String
    property :phone_number, String
  end

  DataMapper.finalize

  Employee.auto_upgrade!

  get '/employee' do
    content_type 'application/xml'
    '<Response><Message>Teste</Message></Response>'
  end

end
