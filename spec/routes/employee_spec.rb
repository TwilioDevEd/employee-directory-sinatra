require_relative '../spec_helper'

describe 'Routes::Employee' do
  let!(:peters) do
    [create(:employee, 'Peter Parker'), create(:employee, 'Peter Quill')]
  end

  describe 'GET: /employee' do
    context 'when looking for Pietro' do
      let(:pietro) { create(:employee, 'Pietro Maximoff') }

      it "returns a TwiML with Pietro's info" do
        get '/employee', Body: pietro.name

        doc = Nokogiri::XML(last_response.body)
        message_body = doc.at_xpath('Response/Message/Body').content
        expect(message_body).to include("#{pietro.id}-#{pietro.name}")
        expect(message_body).to include(pietro.email)
      end

      it "returns Pietro's photo" do
        get '/employee', Body: pietro.name

        doc = Nokogiri::XML(last_response.body)
        media = doc.xpath('Response/Message/Media')
        expect(media.size).to eq(1)
        expect(media.inner_html).to eq(pietro.image_url)
      end
    end

    context 'when looking for Peter' do
      it 'returns the people with the name Peter' do
        get 'employee', Body: 'Peter'

        doc = Nokogiri::XML(last_response.body)
        content = doc.at_xpath('Response/Message').content
        peters.each do |employee|
          expect(content).to include(employee.name)
        end
      end
    end

    context 'when specifying an ID' do
      it "retrieves employee's info" do
        get '/employee', Body: peters.first.id.to_s

        doc = Nokogiri::XML(last_response.body)
        message_body  = doc.at_xpath('Response/Message/Body').content
        message_media = doc.at_xpath('Response/Message/Media').content
        expect(message_body).to include(
          "#{peters.first.id}-#{peters.first.name}")
        expect(message_media).to eq(peters.first.image_url)
      end
    end

    context 'when looking for a nonexisting employee' do
      let(:peters) { [] }
      it 'returns not found' do
        get '/employee', Body: 'unexistent'

        doc = Nokogiri::XML(last_response.body)
        content = doc.at_xpath('Response/Message').content
        expect(content).to eq('not found')
      end
    end
  end
end

private

def create(_, name)
  normalized_name = name.downcase.split.join('_')
  Employee.create(
    name:         name,
    image_url:    "#{normalized_name}.png",
    email:        "#{normalized_name}@example.com",
    phone_number: '555-5555'
  )
end
