require 'rspec'
require 'rack/test'
require 'nokogiri'

require_relative '../employee_directory_app'

RSpec.describe 'Employee Directory App' do
  include Rack::Test::Methods

  def app
    EmployeeDirectoryApp.new
  end

  describe 'employee endpoint' do
    it 'returns a twiml with the employee info' do
      get "employee?name='peter'"
      response = Nokogiri::XML(last_response.body)

      expect(response.xpath('Response/Message'))
        .not_to be_empty
    end
  end
end
