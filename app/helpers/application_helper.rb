# -*- coding: utf-8 -*-
module ApplicationHelper
  # 曜日を出す
  def cwday(cwday_number)
    #str = %w(月 火 水 木 金 土 日)[cwday_number - 1]
    str = %w(MON TUE WED THU FRI SAT SUN)[cwday_number - 1]
    case cwday_number
    when 7
      "<span style='color:red'>#{str}</span>"
    when 6
      "<span style='color:blue'>#{str}</span>"
    else 
      str
    end
    str
  end

  # 曜日クラスを出す
  def cwday_class(cwday_number)
    case cwday_number
    when 7 then 'sunday'
    when 6 then 'saturday'
    else        'weekday'
    end
  end
  # name    : 日付を出す
  # args    : cwday_number
  # author  : chu
  def en_day(day)
    postfix = 
      case day % 10
      when 1 then "st"
      when 2 then "nd"
      when 3 then "rd"
      else        "th"
      end
    "#{day}#{postfix}"
  end

  # name    : ほっとワードを、数でフォント数を変えて表示する 
  # args    : ワードの配列, 名称と頻度のメソッド名
  # comment : 
  # author  : chu
  def hot_word(words)
    frequency_sum = words.sum(&:frequency)
    summary_font_size = words.size * 20
    raw(words.map do |word|
       "<span style='font-size:#{100 + summary_font_size * word.frequency / frequency_sum}%'>#{h(word.name)}</span>"
    end.join(', '))
  end

  # name    : リンクはったり、外部画像呼び出したりする
  # args    : str
  # author  : chu
  # comment : 
  def tweet_images(str)
    # 画像があったら、インラインで表示させる
    images = []
    [
      {
        :url_regexp   => %r|(http://twitpic.com/)([a-zA-Z0-9]+)|,
        :image_regexp => '\1show/thumb/\2'
      },
      {
        :url_regexp   => %r{(http://.+\.(png|jpg|jpeg))},
        :image_regexp => '\1'
      }
    ].each do |service|
      str.gsub(service[:url_regexp]) do
        href = $&
        image_href = href.sub(service[:url_regexp], service[:image_regexp])
        images << link_to(image_tag(image_href, :width => 150), href, :target => '_blank')
      end 
    end 

    images.join('&nbsp;')
  end

  # ユーザを検索するフォーム
  def user_search_form
    raw %q(
      <form action="#" onsubmit='location.href="/" + document.getElementById("screen_name").value; return false;'>
        <input type="text" id="screen_name" name="screen_name" size="20" />
        <input type="button" value="ユーザを検索する"><br/>
      </form>
    )
  end
end
