require_relative '../lib/message_creator'

module Routes
  module Employee
    def self.registered(app)
      app.post '/employee' do
        content_type 'application/xml'

        employees = Searcher.search(params[:Body])
        message_creator = MessageCreator.new(employees)
        case employees.size
        when 0 then message_creator.employee_not_found
        when 1 then message_creator.employee_details
        else message_creator.employees_options
        end
      end
    end
  end
end
