module HotFoodGenerate
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def generate_from(from_time)
      transaction do
        delete_all
        user_foods = UserFood.find(
          :all,
          :group      => 'name',
          :select     => '*, count(name) as count',
          :conditions => ['? < created_at', from_time],
          :order      => 'count DESC',
          :limit      => 20
        )
        
        user_foods.each do |user_food|
          create!(
            :name      => user_food.name,
            :frequency => user_food.count
          )
        end
      end
    end
  end
end

