class MessageCreator
  def initialize(employees)
    @employees = employees
  end

  def employee_not_found_message
    Twilio::TwiML::Response.new do |response|
      response.Message 'not found'
    end.to_xml
  end

  def listing_message
    Twilio::TwiML::Response.new do |response|
      response.Message employees_label_list.join(' ')
    end.to_xml
  end

  def employees_label_list
    employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
  end

  def details_message
    employee = employees.first

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

  private

  attr_reader :employees
end
