# -*- coding: utf-8 -*-
#require 'twitter'
require 'json'
require 'net/http'
require 'image_url'
class Tweet < ActiveRecord::Base
  belongs_to :user #, :primary_key => 'twitter_id'
  validates_uniqueness_of :twitter_post_id

  # name    : 形態素解析する 
  # comment : 
  # author  : chu
  def extract_keyphrase
    Tweet.transaction do
      UserFood.create_from_tweet(self)
      self.analyzed = true
      self.save!
    end
  end

  class << self
    # name    : フォロワーのTLを取得してDBにいれる
    # args    : 
    # comment : 
    # author  : chu
    def fetch_timeline
      Twitter.configure do |config|
        config.consumer_key       = CONSUMER_KEY
        config.consumer_secret    = CONSUMER_SECRET
        config.oauth_token        = EAT_LOG_ACCESS_TOKEN
        config.oauth_token_secret = EAT_LOG_ACCESS_TOKEN_SECRET
      end
      

      #oauth = Twitter::OAuth.new(Consumer::CONSUMER_KEY, Consumer::CONSUMER_SECRET)
      #oauth.authorize_from_access(EAT_LOG_ACCESS_TOKEN, EAT_LOG_ACCESS_TOKEN_SECRET)
      #client = Twitter::Base.new(oauth)
      client = Twitter::Client.new

      # フォロワーがDBにあるか、を調べる。
      # ないユーザは作成し、またフォローしていないユーザはフォローする
      last_tweet_id = AppConfig.get(:last_tweet_id) rescue 1
      timeline = client.home_timeline(:count => 200, :since_id => last_tweet_id)
      timeline.each do |post|
        
        if eat?(post.text) 
          text = post.text

          # expand t.co
          if text =~ %r|http://t\.co/|
            tco_urls = text.scan(%r|http://t\.co/\w+|).uniq
            original_urls = Twitter.resolve(tco_urls).values
            tco_urls.each_with_index do |tco_url, i|
              text.gsub!(tco_url, original_urls[i])
            end
          end

          # expand instagr.am
          text.scan(%r|http://instagr.am/p/.+?/|).each do |instagram_url|
            text.gsub!(instagram_url, ImageUrl.instagram(instagram_url))
          end

          tweet = Tweet.create(
            :twitter_post_id => post.id,
            :text            => text,
            :user_id         => post.user.id,
            :created_at      => post.created_at
          )
        end
        #p timeline.id
      end

      # 取得した最後の id を保存する
      AppConfig.set(:last_tweet_id, timeline.first.id) if timeline.first

      nil
    end

    # name    : 食べたか判定するメソッド
    # args    : 投稿された文字列
    # comment : OK : 食べた 食べます 食べよう 食べる 食べました 食べちゃった
    #           NG : 食べたい 食べない 食べません 食べなかった 食べちゃってない 食べてない
    # author  : chu
    def eat?(str)
      #ok_pattern = /((食|た)べ(た|ます|よう|る|ました|ちゃった|てます|ています|てる)|(食|く)っ(た|てる|ている|ちゃった|てます|ています)|(食|しょく)(している|してる|す))/
      #ng_pattern = /(食|た)べ(たい|ない|ません|なかった|ちゃってない|てない)/
      # RT, QT, XT などがあったらその後は無視する。
      match_str = str.sub(/^(.*?)\sRT.*/, '\1')
      #match_str =~ ok_pattern && str !~ ng_pattern
      match_str =~ /#eat/
    end

    def expand_t_co(url)
      Twitter.resolve(url).values.first
    end

    # name    : まだ解析していないTweetを解析する
    # args    : 
    # comment : 
    # author  : chu
    def analyze_phrase
      find(
        :all, 
        :conditions => ['analyzed = ?', false]
      ).each do |tweet|
        next if tweet.analyzed?
        tweet.extract_keyphrase
        sleep 1
      end
      nil
    end

  end
end
