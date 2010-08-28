class CreateDailyHotFoods < ActiveRecord::Migration
  def self.up
    create_table :daily_hot_foods do |t|
      t.string   :name, :null => false, :limit => 30
      t.integer  :frequency, :null => false, :default => 0
      t.datetime :created_at, :null => false
    end
    add_index :daily_hot_foods, :frequency
  end

  def self.down
    remove_index :daily_hot_foods, :column => :frequency
    drop_table :daily_hot_foods
  end
end
