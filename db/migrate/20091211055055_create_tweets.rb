class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :user_id, :twitter_post_id, :null => false, :default => 0
      t.string  :text
      t.timestamps :null => false
    end
    add_index :tweets, :user_id
    add_index :tweets, :created_at
  end

  def self.down
    remove_index :tweets, :column => :created_at
    remove_index :tweets, :column => :user_id
    drop_table :tweets
  end
end
