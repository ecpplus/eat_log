# -*- coding: utf-8 -*-
class AuthController < ApplicationController

  def index
    oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
    oauth.authorize_from_access(session[:access_token], session[:access_token_secret])
    client = Twitter::Base.new(oauth)
  end

  def oauth
    # :oauth_callbackに認証後のコールバックURLを指定
    # この場合だとこのコントローラー内の oauth_callback メソッドが実行される
    request_token = Consumer.new.get_request_token(
      :oauth_callback => "http://#{request.host_with_port}/auth/oauth_callback"
    )
    p "http://#{request.host_with_port}/auth/oauth_callback"
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    # twitter.comで認証する
    redirect_to request_token.authorize_url
    return
  end
  
  def oauth_callback
    consumer = Consumer.new
    access_token = AccessToken.get(consumer, session, params)
    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret

    response = consumer.request(
      :get,
      '/account/verify_credentials.json',
      access_token, { :scheme => :query_string }
    )
    case response
    when Net::HTTPSuccess
      @user_info = JSON.parse(response.body)
      if @user_info['screen_name']
        user = User.by_credential(@user_info)
        self.current_user = user
        flash[:notice] = 'ログインしました。'
        if params[:backto]
          redirect_to params[:backto]
          return
        else
          redirect_to home_path
          return
        end
      else
        flash[:notice] = "Authentication failed"
        redirect_to :action => :index
        return
      end
      redirect_to root_path
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
    end
  end

  def logout
    logout_killing_session!
    flash[:notice] = 'ログアウトしました。'
    redirect_to root_path
  end

end
