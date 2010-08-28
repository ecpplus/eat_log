require 'uri'
class UserFood < ActiveRecord::Base
  class << self
    # name    : Tweet を元に作成する。
    # args    : 
    # comment : 
    # author  : chu
    def create_from_tweet(tweet)
      # Yahoo! API に投げる
      host = "jlp.yahooapis.jp"
      path = "/KeyphraseService/V1/extract?appid=#{YAHOO_API_ID}&output=json&sentence=#{URI.encode(tweet.text)}&filter=9"

      begin
        Net::HTTP.start(host, 80) do |http|
          response = http.get(path)
          @phrases = JSON.parse(response.body)
        end
      rescue => e
        logger.error "NG text : #{tweet.text}"
        logger.error "ErrorMsg: #{e.message}"
        logger.error e.backtrace.join("\n")
        p tweet.text
        p "ErrorMsg: #{e.message}"
        print e.backtrace.join("\n")
      end

      # それぞれについて、DBに入れる。
      @phrases.each do |phrase, score|
        # UserFood を作る
        user_food = create!(
          :user_id => tweet.user_id,
          :name    => phrase,
          :score   => score
        )

        # UserHotFood の数を増やす
        user_hot_food = UserHotFood.find_or_initialize_by_user_id_and_name(tweet.user_id, phrase)
        user_hot_food.frequency += 1
        user_hot_food.save!
      end
    end
  end
end
