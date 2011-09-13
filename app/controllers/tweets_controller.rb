# -*- coding: utf-8 -*-
class TweetsController < ApplicationController
  before_filter :login_required

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.destroy
      flash[:notice] = 'Tweet を削除しました。'
      redirect_to :controller => :user, :action => :show, :id => @tweet.user.screen_name,
                  :month => @tweet.created_at.strftime('%Y%m')
    else
      flash[:error] = 'この Tweet を削除することは出来ません。'
      redirect_to :controller => :user, :action => :show, :id => @tweet.user.screen_name,
                  :month => @tweet.created_at.strftime('%Y%m')
    end
  end
end
