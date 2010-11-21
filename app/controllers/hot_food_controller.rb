class HotFoodController < ApplicationController
  def index
    @weekly_hot_foods = WeeklyHotFood.all
    @recent_tweets = Tweet.order('tweets.created_at DESC').includes(:user).limit(20)
  end
end
