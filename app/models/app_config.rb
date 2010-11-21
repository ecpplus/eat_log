# -*- coding: utf-8 -*-
class AppConfig < ActiveRecord::Base
  class << self
    # name    : キーの値を読み出す。
    # args    : key 
    # author  : chu
    def get(key)
      find_by_key(key.to_s).value
    end

    def set(key, value)
      app_config = find_or_initialize_by_key(key.to_s)
      app_config.value = value
      app_config.save!
    end
  end
end
