module ApplicationHelper

  def nice_date_format(the_date)
    return the_date.strftime('%Y-%m-%d')
  end

  def nice_time_format(the_time)
    return the_time.strftime('%H:%M')
  end

  
  def places_left_for(plan)
    if plan.id == 2
      places_left = Center.first.max_members - @bank_members - @max_plan3_and_4 - plan.subscriptions.count
    elsif plan.id >= 3
      places_left = plan.max_members - plan.subscriptions.count
    end
    return places_left
  end


end
