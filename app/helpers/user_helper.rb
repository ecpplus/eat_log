module UserHelper
  def month_options(user)
    date = user.created_at.beginning_of_month
    time_now = Time.now
    ary = []
    while date < time_now
      ary << [date.strftime('%Y年%m月'), date.strftime('%Y%m')]
      date = date.next_month
    end
    ary
  end
end
