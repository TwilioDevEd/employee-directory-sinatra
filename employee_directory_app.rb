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
    employees = search(params['body'])

    content_type 'application/xml'
    to_twiml(employees).to_xml
  end

  def search(employee_reference)
    if is_number? employee_reference
      [Employee.get(employee_reference)]
    else
      Employee.all(:name.like => "%#{employee_reference}%")
    end
  end

  def is_number?(value)
    value =~ /^\d*$/
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
