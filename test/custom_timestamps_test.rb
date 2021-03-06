require 'test_helper'
require 'models/pirate'
require 'models/ship'

class CustomTimestampsTest < ActiveSupport::TestCase
  test "A pirate sets drunk_for_the_first_time_at when created" do
    pirate = Pirate.new(:name => "Jack")
    pirate.save!
    assert_not_nil pirate.drunk_for_the_first_time_at
  end
  
  test "A pirate sets drunk_last_at when created" do
    pirate = Pirate.new(:name => "Jack")
    pirate.save!
    assert_not_nil pirate.drunk_last_at
  end
  
  test "A pirate sets drunk_last_at when updated" do
    pirate = Pirate.new(:name => 'Jack', :drunk_last_at => 2.weeks.ago)
    pirate.save!
    
    pirate.name = "Jack 2"
    pirate.save!
    
    assert pirate.drunk_last_at > 1.day.ago
  end
  
  test "Association saving still works" do
    pirate = Pirate.new(:name => 'Colombus')
    pirate.ships.build(:name => 'Pinta')
    
    pirate.save!
    
    assert !pirate.ships.any?(&:new_record?)
  end
end
