require 'sinatra'
require 'data_mapper'
require 'twilio-ruby'
require_relative 'employee'
require_relative 'employee_directory/employee_directory'

class EmployeeDirectoryApp < Sinatra::Application

  DataMapper.setup(:default, ENV['EMPLOYEE_DIR_DATABASE_URL'])

  DataMapper.finalize

  Employee.auto_upgrade!

  get '/employee' do
    employees = EmployeeDirectory::search(params['body'])

    content_type 'application/xml'
    to_twiml(employees).to_xml
  end

  def to_twiml(employees)
    employees_name_list = employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
    Twilio::TwiML::Response.new do |response|
      response.Message employees_name_list.join(' ')
    end
  end

  run! if app_file == $0
end
