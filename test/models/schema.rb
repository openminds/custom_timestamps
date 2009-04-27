ActiveRecord::Schema.define do
  create_table "pirates", :force => true do |t|
    t.column "name",  :text
    t.column "drunk_for_the_first_time_at", :datetime
    t.column "drunk_last_at", :datetime
  end
end