class AuthController < ApplicationController

  def index
    oauth = Twitter::OAuth.new(Consumer::CONSUMER_KEY, Consumer::CONSUMER_SECRET)
    oauth.authorize_from_access(session[:access_token], session[:access_token_secret])
    p session[:access_token]
    p session[:access_token_secret]


    client = Twitter::Base.new(oauth)
    #client.update('@eat_log にゃんにゃん。')
    #p client.mentions.first.text
    p client
    p screen_name = client.followers.map(&:screen_name).first
    #p client.friendship_create(screen_name)
    
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
    p 'callback ktkr!!'

    consumer = Consumer.new
    access_token = AccessToken.get(consumer, session, params)
    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret

    #p "session[:request_token] : #{session[:request_token]}"
    #p "session[:request_token_secret] : #{session[:request_token_secret]}"
    #p "session[:access_token] : #{session[:access_token]}"
    #p "session[:access_token_secret] : #{session[:access_token_secret]}"

    #request_token = OAuth::RequestToken.new(
    #  consumer,
    #  session[:request_token],
    #  session[:request_token_secret]
    #)
 
    #access_token = request_token.get_access_token(
    #  {},
    #  :oauth_token => params[:oauth_token],
    #  :oauth_verifier => params[:oauth_verifier]
    #)
 
    response = consumer.request(
      :get,
      '/account/verify_credentials.json',
      access_token, { :scheme => :query_string }
    )
    case response
    when Net::HTTPSuccess
      @user_info = JSON.parse(response.body)
      #p @user_info
      if @user_info['screen_name']
        user = User.by_credential(@user_info)
        self.current_user = user
        if params[:backto]
          redirect_to params[:backto]
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

end
