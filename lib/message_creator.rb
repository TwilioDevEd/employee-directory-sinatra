class MessageCreator
  def initialize(employees)
    @employees = employees
  end

  def employee_not_found
    response = Twilio::TwiML::MessagingResponse.new
    response.message(body: 'not found')
    response.to_s
  end

  def employees_options
    response = Twilio::TwiML::MessagingResponse.new
    response.message(body: employees_labels.join(' '))
    response.to_s
  end

  def employee_details
    employee = employees.first

    response = Twilio::TwiML::MessagingResponse.new
    message = Twilio::TwiML::Message.new
    body = Twilio::TwiML::Body.new(format_employee_info(employee))
    media = Twilio::TwiML::Media.new(employee.image_url)

    response.append(message)
    message.append(body)
    message.append(media)

    response.to_s
  end

  private

  attr_reader :employees

  def employees_labels
    employees.map do |employee|
      "#{employee.id}-#{employee.name}"
    end
  end

  def format_employee_info(employee)
    "#{employee.id}-#{employee.name}" \
      " #{employee.email}" \
      " #{employee.phone_number}"
  end
end
