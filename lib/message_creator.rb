class MessageCreator
  def initialize(employees)
    @employees = employees
  end

  def employee_not_found
    response = Twilio::TwiML::MessagingResponse.new
    response.message 'not found'
    response.to_xml_str
  end

  def employees_options
    response = Twilio::TwiML::MessagingResponse.new
    response.message employees_labels.join(' ')
    response.to_xml_str
  end

  def employee_details
    employee = employees.first

    employee_info = "#{employee.id}-#{employee.name}" \
      " #{employee.email}" \
      " #{employee.phone_number}"

    response = Twilio::TwiML::MessagingResponse.new
    message = Twilio::TwiML::Message.new
    body = Twilio::TwiML::Body.new(employee_info)
    media = Twilio::TwiML::Media.new(employee.image_url)

    response.append(message)
    message.append(body)
    message.append(media)

    response.to_xml_str
  end

  private

  attr_reader :employees

  def employees_labels
    employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
  end
end
