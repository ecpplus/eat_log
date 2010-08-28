require 'rubygems'
require 'twitter'
class User < ActiveRecord::Base
  has_many :tweets, :primary_key => :twitter_id
  set_primary_key :twitter_id
  validates_presence_of   :screen_name
  validates_uniqueness_of :twitter_id, :screen_name

  # name    : カスタムバリデーション
  # comment : - twitter_id は必ず指定されている必要がある
  # author  : chu
  def validate
    if twitter_id.blank? || twitter_id.zero?
      self.errors.add :twitter_id, 'が設定されていません。'
    end
  end

  # name    : 表示する時の名前
  # comment : ちゅう(@ecpplus) と出る
  # author  : chu
  def view_name
    "#{name} (@#{screen_name})"
  end

  def favorite_foods(opt)
    _opt = {
      :conditions => ['user_id = ?', twitter_id],
      :order => 'frequency DESC'
    }
    _opt.merge!(opt)

    p _opt

    UserHotFood.find(:all, _opt)
  end

  class << self
    # name    : Twitterから取得した情報をもとにユーザを作成
    # args    : 
    # comment : 
    # author  : chu
    def by_credential(credential)
      user = self.find_or_initialize_by_twitter_id(credential["id"])
      user.twitter_id        = credential["id"]
      user.screen_name       = credential["screen_name"]
      user.name              = credential["name"]
      #user.description       = credential["description"]
      user.profile_image_url = credential["profile_image_url"]
      #user.url               = credential["url"]
      #user.location          = credential["location"]
      user.save!
      user
    end 
  end

end
