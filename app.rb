require 'sinatra'
require 'data_mapper'
require 'twilio-ruby'
require_relative 'employee_directory/employee_directory'

class EmployeeDirectoryApp < Sinatra::Application
  set :employee_directory,
      EmployeeDirectory.init(ENV['EMPLOYEE_DIR_DATABASE_URL'])

  get '/employee' do
    employees = settings.employee_directory.search(params['Body'])

    content_type 'application/xml'

    case employees.size
    when 0 then employee_not_found_message
    when 1 then details_message(employees.first)
    else listing_message(employees)
    end
  end

  private

  def employee_not_found_message
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

  run! if app_file == $PROGRAM_NAME
end
