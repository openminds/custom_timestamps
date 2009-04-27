require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'lib/defv/custom_timestamps'
require 'init'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => 'test.db'
})

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  
  load 'models/schema.rb'
end