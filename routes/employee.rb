require_relative '../lib/message_creator'

module Routes
  module Employee
    def self.registered(app)
      app.post '/employee' do
        content_type 'application/xml'

        employees = Searcher.search(params[:Body])
        message_creator = MessageCreator.new(employees)
        case employees.size
        when 0 then message_creator.employee_not_found_message
        when 1 then message_creator.details_message
        else message_creator.listing_message
        end
      end
    end
  end
end
