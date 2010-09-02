class CreateBlackWords < ActiveRecord::Migration
  def self.up
    create_table :black_words do |t|
      t.string :word, :null => false, :maxlength => 50
    end
    add_index :black_words, :word
  end

  def self.down
    drop_table :black_words
  end
end
