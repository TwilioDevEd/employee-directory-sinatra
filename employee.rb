require 'data_mapper'

class Employee
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :image_url, String
  property :email, String
  property :phone_number, String
end
