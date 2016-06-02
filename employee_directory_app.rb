require 'sinatra'
require 'data_mapper'
require 'twilio-ruby'
require_relative 'employee'
require_relative 'employee_directory/employee_directory'
require_relative 'seeder'

class EmployeeDirectoryApp < Sinatra::Application

  DataMapper.setup(:default, ENV['EMPLOYEE_DIR_DATABASE_URL'])

  DataMapper.finalize

  Employee.auto_upgrade!

  Seeder.seed

  get '/employee' do
    employees = EmployeeDirectory::search(params['Body'])

    content_type 'application/xml'

    if employees.size == 0
      r = Twilio::TwiML::Response.new do |response|
        response.Message 'not found'
      end
      r.to_xml
    elsif employees.size > 1
      to_twiml(employees).to_xml
    else
      show(employees.first).to_xml
    end
  end

  def to_twiml(employees)
    employees_name_list = employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
    Twilio::TwiML::Response.new do |response|
      response.Message employees_name_list.join(' ')
    end
  end

  def show(employee)
    Twilio::TwiML::Response.new do |response|
      response.Message "#{employee.id}-#{employee.name}"
      response.Media employee.image_url
    end
  end

  run! if app_file == $0
end
