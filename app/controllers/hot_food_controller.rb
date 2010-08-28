class HotFoodController < ApplicationController
  def index
    #@daily_hot_foods  = DailyHotFood.find(:all)
    @weekly_hot_foods = WeeklyHotFood.find(:all)

    @recent_tweets = Tweet.find(
      :all,
      :include => :user,
      :order   => 'created_at DESC',
      :limit   => 20
    )
  end
end
