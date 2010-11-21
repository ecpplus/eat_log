# -*- coding: utf-8 -*-
require Rails.root.to_s + '/lib/hot_food_generate'
class WeeklyHotFood < ActiveRecord::Base
  include HotFoodGenerate

  class << self
    # name    : 集計して、1週間ごとのホットなものを抽出する
    # args    : 
    # comment : 
    # author  : chu
    def generate
      generate_from(DateTime.now.ago(1.week + 9.hours))
    end
  end

end
