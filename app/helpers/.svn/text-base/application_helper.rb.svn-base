# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # name    : 曜日を出す
  # args    : cwday_number
  # author  : chu
  def cwday(cwday_number)
    str = %w(月 火 水 木 金 土 日)[cwday_number - 1]
    case cwday_number
    when 7
      "<span style='color:red'>#{str}</span>"
    when 6
      "<span style='color:blue'>#{str}</span>"
    else 
      str
    end
  end

  # name    : ほっとワードを、数でフォント数を変えて表示する 
  # args    : ワードの配列, 名称と頻度のメソッド名
  # comment : 
  # author  : chu
  def hot_word(words)
    frequency_sum = words.sum(&:frequency)
    summary_font_size = words.size * 50
    words.map do |word|
      "<span style='font-size:#{100 + summary_font_size * word.frequency / frequency_sum}%'>#{h(word.name)}</span>"
    end.join(', ')
  end


end
