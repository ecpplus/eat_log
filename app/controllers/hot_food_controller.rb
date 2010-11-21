class HotFoodController < ApplicationController
  def index
    #@daily_hot_foods  = DailyHotFood.find(:all)
    @weekly_hot_foods = WeeklyHotFood.all

    #@recent_tweets = Tweet.includes(:user)
    @recent_tweets = Tweet.order('tweets.created_at DESC').limit(20) #.includes(:user)
    #@recent_tweets = Tweet.order('created_at DESC').limit(20).includes(:user)
    #@recent_tweets.order('created_at DESC')
    #@recent_tweets.includes(:user)
    #@recent_tweets.limit(20)

    #@recent_tweets = Tweet.all(
    #  :include => :user,
    #  :order   => 'created_at DESC',
    #  :limit   => 20
    #)
  end
end
