require 'data_mapper'
require_relative 'seeder'
require_relative 'employee'

module EmployeeDirectory
  class Searcher
    def search(employee_reference)
      if employee_reference =~ /^\d*$/
        [Employee.get(employee_reference)]
      else
        Employee.all(:name.like => "%#{employee_reference}%")
      end
    end
  end

  module_function

  def init(database_url)
    DataMapper.setup(:default, database_url)
    DataMapper.finalize
    Employee.auto_upgrade!
    Seeder.seed

    Searcher.new
  end
end
