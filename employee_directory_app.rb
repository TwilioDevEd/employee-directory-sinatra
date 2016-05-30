require 'sinatra'

class EmployeeDirectoryApp < Sinatra::Application

  get '/employee' do
    content_type 'application/xml'
    '<Response><Message>Teste</Message></Response>'
  end

end
