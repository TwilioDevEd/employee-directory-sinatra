require_relative 'employee'
require 'json'

class Seeder
  def self.seed
    Employee.destroy

    json_file = File.read('employee_directory/seed-data.json')
    employees = JSON.parse(json_file)

    employees.each do |employee|
      Employee.create(employee)
    end
  end
end
