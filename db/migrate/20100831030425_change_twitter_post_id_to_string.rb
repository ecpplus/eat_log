class ChangeTwitterPostIdToString < ActiveRecord::Migration
  def self.up
    change_column :tweets, :twitter_post_id, :string
  end

  def self.down
    change_column :tweets, :twitter_post_id, :integer
  end
end
