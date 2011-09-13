class HotFoodController < ApplicationController
  def index
    @weekly_hot_foods = WeeklyHotFood.all
    @recent_tweets = Tweet.where('? <= tweets.created_at', 2.weeks.ago.beginning_of_day).order('tweets.created_at DESC').includes(:user).limit(20)
  end
end
