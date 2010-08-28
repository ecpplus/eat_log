class HotFoodController < ApplicationController
  def index
    p session[:twitter_id]
    p session
    @daily_hot_foods  = DailyHotFood.find(:all)
    @weekly_hot_foods = WeeklyHotFood.find(:all)
  end
end
