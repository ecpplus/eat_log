# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'twitter'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password

  include AuthenticatedSystem

  protected
  def oauth
    if logged_in?
      current_user
      return true 
    end 

    # :oauth_callbackに認証後のコールバックURLを指定
    # この場合だとこのコントローラー内の oauth_callback メソッドが実行される
    callback_url = "http://#{request.host_with_port}/auth/oauth_callback"
    #callback_url += ("?backto=" + opt[:backto]) if opt[:backto]
    callback_url += ("?backto=" + request.path) 

    request_token = Consumer.new.get_request_token(
      :oauth_callback => callback_url
    )   
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    # twitter.comで認証する
    redirect_to request_token.authorize_url
  end 


end
