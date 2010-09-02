class AccessToken 

  class << self
    def get(consumer, session, params)
      request_token = OAuth::RequestToken.new(
        consumer,
        session[:request_token],
        session[:request_token_secret]
      )

      access_token = request_token.get_access_token(
        {},
        :oauth_token => params[:oauth_token],
        :oauth_verifier => params[:oauth_verifier]
      )
    end
  end

end
