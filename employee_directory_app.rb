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
      employee_not_found_message
    elsif employees.size > 1
      listing_message(employees)
    else
      details_message(employees.first)
    end
  end

  private
  def employee_not_found_message()
    Twilio::TwiML::Response.new do |response|
      response.Message 'not found'
    end.to_xml
  end

  def listing_message(employees)
    Twilio::TwiML::Response.new do |response|
      response.Message employees_label_list(employees).join(' ')
    end.to_xml
  end

  def employees_label_list(employees)
    employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
  end

  def details_message(employee)
    Twilio::TwiML::Response.new do |response|
      employee_info = "#{employee.id}-#{employee.name}"\
        " #{employee.email}"\
        " #{employee.phone_number}"

      response.Message do |message|
        message.Body employee_info
        message.Media employee.image_url
      end
    end.to_xml
  end

  run! if app_file == $0
end
