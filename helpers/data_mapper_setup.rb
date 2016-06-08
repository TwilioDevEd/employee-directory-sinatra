require 'data_mapper'
require_relative 'seeder'

module Helpers
  module DataMapperSetup
    def self.setup(database_url)
      DataMapper.setup(:default, database_url)
      DataMapper.finalize
      Employee.auto_upgrade!
      Seeder.seed
    end
  end
end
