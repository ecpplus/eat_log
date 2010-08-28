class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :screen_name, :null => false 
      t.string :name, :description, :access_token, :access_token_secret, :profile_image_url
      t.integer :twitter_id, :null => false
      t.boolean :followed, :removed, :null => false, :default => false
      t.timestamps :null => false
    end
    add_index :users, :screen_name
    add_index :users, :twitter_id
  end

  def self.down
    drop_table :users
  end
end
