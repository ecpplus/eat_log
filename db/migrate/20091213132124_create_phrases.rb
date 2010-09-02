class CreatePhrases < ActiveRecord::Migration
  def self.up
    create_table :phrases do |t|
      t.string     :name, :null => false, :limit => 30
      t.boolean    :food, :null => false, :default => true
      t.timestamps :null => false
    end
    add_index :phrases, :name
  end

  def self.down
    remove_index :phrases, :column => :name
    drop_table :phrases
  end
end
