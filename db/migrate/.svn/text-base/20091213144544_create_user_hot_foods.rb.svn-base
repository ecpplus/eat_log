class CreateUserHotFoods < ActiveRecord::Migration
  def self.up
    create_table :user_hot_foods do |t|
      t.integer :user_id, :frequency, :null => false, :default => 0
      t.string  :name, :null => false, :limit => 30
    end
    add_index :user_hot_foods, [:user_id, :name]
    add_index :user_hot_foods, [:user_id, :frequency], :name => 'user_id_frequency'
  end

  def self.down
    remove_index :user_hot_foods, :column => [:user_id, :name]
    drop_table :user_hot_foods
  end
end
