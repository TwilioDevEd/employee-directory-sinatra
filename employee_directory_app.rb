require 'sinatra'
require 'data_mapper'
require 'twilio-ruby'
require_relative 'employee'

class EmployeeDirectoryApp < Sinatra::Application

  DataMapper.setup(:default,
                   "sqlite3://#{Dir.pwd}/employee_dir_test_database.db")

  DataMapper.finalize

  Employee.auto_upgrade!

  get '/employee' do
    content_type 'application/xml'

    employees = if is_number?(params['body'])
      [Employee.get(params['body'])]
    else
      Employee.all(:name.like => "%#{params['body']}%")
    end

    to_twiml(employees).to_xml
  end

  def is_number?(value)
    value =~ /^\d*$/
  end

  def to_twiml(employees)
    employees_name_list = employees.map { |employee| "#{employee.name}" }
    Twilio::TwiML::Response.new do |response|
      response.Message employees_name_list.join('\n')
    end
  end

  run! if app_file == $0
end
