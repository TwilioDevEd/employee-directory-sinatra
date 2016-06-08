require 'data_mapper'

class Employee
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :image_url, String, length: 200
  property :email, String
  property :phone_number, String
end
