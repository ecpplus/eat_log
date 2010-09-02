class AddAnalyzedToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :analyzed, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :tweets, :analyzed
  end
end
