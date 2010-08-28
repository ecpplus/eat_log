class UserController < ApplicationController
  def show
    @user = User.find_by_screen_name(params[:id])
    unless @user
      flash[:error] = 'ユーザが見つかりません。@eat_log をフォローしてください。<br />フォローしている場合は、10分ほどお待ち下さいませ。'
      redirect_to :controller => 'hot_food', :action => 'index'
      return
    end

    if params[:month].to_s =~ /\d{6}/
      @month_start  = DateTime.new(params[:month].to_s[0..3], params[:month].to_s[4..5], 1)
      @month_finish = @month_start.end_of_month
    else
      @month_start  = DateTime.now.beginning_of_month
      @month_finish = @month_start.end_of_month
    end
    
    # 対象月の食べる関係の発言を取得
    @tweets = Tweet.find(
      :all,
      :conditions => [
        'user_id = :user_id AND created_at BETWEEN :start AND :finish',
        {:user_id => @user.twitter_id, :start => @month_start, :finish => @month_finish}
      ],
      :order => 'created_at ASC'
    )

    # 過去の、お気に入りの食べ物を取得
    @favorite_foods = UserHotFood.find(
      :all,
      :conditions => ['user_id = ?', @user.twitter_id],
      :order => 'frequency DESC'
    )
  end
end
