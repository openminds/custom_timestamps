class Pirate < ActiveRecord::Base
  set_create_column :drunk_for_the_first_time_at
  set_update_column :drunk_last_at
  
  has_many :ships
end