class BlackWord < ActiveRecord::Base
  class << self
    def delete_user_food
      all.each do |black_word| 
        UserFood.delete_all(["name = ?", black_word.word])
      end
    end
  end
end
