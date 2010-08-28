class CreateUserFoods < ActiveRecord::Migration
  def self.up
    create_table :user_foods do |t|
      t.integer  :user_id, :score, :null => false, :default => 0
      t.string   :name, :null => false, :limit => 30
      t.datetime :created_at, :null => false
    end
    add_index :user_foods, [:user_id]
    add_index :user_foods, [:user_id, :name], :name => 'user_id_name'
  end

  def self.down
    remove_index :user_foods, :name => 'user_id_name'
    remove_index :user_foods, :column => [:user_id]
    drop_table :user_foods
  end
end
