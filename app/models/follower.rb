# -*- coding: utf-8 -*-
class Follower < ActiveRecord::Base

  class << self
    # name    : まだフォローしていないユーザをフォローする
    # args    : 
    # comment : 
    # author  : chu
    def follow_users
      oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
      oauth.authorize_from_access(EAT_LOG_ACCESS_TOKEN, EAT_LOG_ACCESS_TOKEN_SECRET)
      client = Twitter::Base.new(oauth)

      # フォロワーがDBにあるか、を調べる。
      # ないユーザは作成し、またフォローしていないユーザはフォローする
      User.transaction do 
        client.followers.each do |follower|
          user = User.find_or_initialize_by_twitter_id(follower.id)

          user.name = follower.name
          user.screen_name = follower.screen_name
          user.description = follower.description
          user.profile_image_url = follower.profile_image_url

          unless follower.following
            client.friendship_create(follower.screen_name)
            user.followed = true
          end
          user.save!
        end
      end
      nil
    end
  end
end
