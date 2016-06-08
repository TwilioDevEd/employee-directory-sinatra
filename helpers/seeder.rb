require 'json'

module Helpers
  module Seeder
    def self.seed
      Employee.destroy

      file = File.read('data/employees.json')
      employees = JSON.parse(file)

      employees.each do |employee|
        Employee.create(employee)
      end
    end
  end
end
