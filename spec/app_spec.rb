require 'rspec'
require 'rack/test'
require 'nokogiri'
require_relative '../employee_directory/employee'

ENV['EMPLOYEE_DIR_DATABASE_URL'] = "sqlite3://#{Dir.pwd}/employee_dir_test_database.db"
require_relative '../employee_directory_app'

RSpec.describe 'Employee Directory App' do
  include Rack::Test::Methods


  def app
    EmployeeDirectoryApp.new
  end

  before(:each) {
    Employee.destroy
  }

  let(:peters) {[
    Employee.create(
      name: 'Peter Parker',
      image_url: 'test',
      email: 'peter@email.com',
      phone_number: '0000-0000'
    ),
    Employee.create(
      name: 'Peter Quill',
      image_url: 'test',
      email: 'quill@email.com',
      phone_number: '0000-0000'
    )
  ]}

  let(:pietro) {
    Employee.create(
      name: 'Pietro Maximoff',
      image_url: 'teste',
      email: 'pietro@email.com',
      phone_number: '0000-0000'
    )
  }

  describe 'employee endpoint' do
    context 'when looking for pietro' do
      it 'returns a twiml with pietro info' do
        get "employee?Body=#{pietro.name}"
        response = Nokogiri::XML(last_response.body)
        messages = response.xpath('Response/Message/Body')
        expect(messages.size).to eq(1)
        expect(messages.inner_html)
          .to include("#{pietro.id}-#{pietro.name}")
        expect(messages.inner_html)
          .to include(pietro.email)
        expect(messages.inner_html)
          .to include(pietro.phone_number)
      end
      it 'return pietro photo' do
        get "employee?Body=#{pietro.name}"

        response = Nokogiri::XML(last_response.body)
        media = response.xpath('Response/Message/Media')
        expect(media.size).to eq(1)
        expect(media.inner_html).to eq(pietro.image_url)
      end
    end
    context 'when looking for Peter' do
      it 'returns everybody named as Peter' do
        peters
        get "employee?Body=Peter"

        response = Nokogiri::XML(last_response.body)
        messages = response.xpath('Response/Message')
        expect(messages.size).to eq(1)
        peters.each do |employee|
          expect(messages.first.inner_html).to include(employee.name)
        end
      end
    end
    context 'when specifying an id' do
      it 'retrieves the employee info' do
        get "employee?Body=#{peters.first.id}"

        response = Nokogiri::XML(last_response.body)
        messages = response.xpath('Response/Message/Body')
        media = response.xpath('Response/Message/Media')
        expect(messages.size).to eq(1)
        expect(media.size).to eq(1)
        expect(messages.first.inner_html).
          to include("#{peters.first.id}-#{peters.first.name}")
        expect(media.first.inner_html).
          to eq(peters.first.image_url)
      end
    end
    context 'when looking for unexistent employee' do
      it 'informs that no employee was found' do
        get 'employee?body=unexistent'

        response = Nokogiri::XML(last_response.body)
        messages = response.xpath('Response/Message')

        expect(messages.size).to eq(1)
        expect(messages.first.inner_html).
          to include('not found')
      end
    end
  end
end
