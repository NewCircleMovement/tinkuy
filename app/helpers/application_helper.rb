module ApplicationHelper

  def nice_date_format(the_date)
    return the_date.strftime('%Y-%m-%d')
  end

  def nice_time_format(the_time)
    return the_time.strftime('%H:%M')
  end

end
