class MessageCreator
  def initialize(employees)
    @employees = employees
  end

  def employee_not_found
    Twilio::TwiML::Response.new do |response|
      response.Message 'not found'
    end.to_xml
  end

  def employees_options
    Twilio::TwiML::Response.new do |response|
      response.Message employees_labels.join(' ')
    end.to_xml
  end

  def employee_details
    employee = employees.first

    Twilio::TwiML::Response.new do |response|
      employee_info = "#{employee.id}-#{employee.name}" \
      " #{employee.email}" \
      " #{employee.phone_number}"

      response.Message do |message|
        message.Body employee_info
        message.Media employee.image_url
      end
    end.to_xml
  end

  private

  attr_reader :employees

  def employees_labels
    employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
  end
end
