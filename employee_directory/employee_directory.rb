require 'data_mapper'
require_relative 'seeder'

module EmployeeDirectory
  module_function

  def init(database_url)
    DataMapper.setup(:default, database_url)
    DataMapper.finalize
    Employee.auto_upgrade!
    Seeder.seed
  end
end
