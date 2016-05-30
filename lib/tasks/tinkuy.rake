namespace :tinkuy do

  desc "Assign timeslots to users"
  task :assign_timeslots => :environment do
    Time.zone = 'Copenhagen'
    today = Date.today
    limit = today + 7.days

    Resource.all.each do |resource|
      resource.timeslots.where(:startdate => today..limit).each do |timeslot|
        if timeslot.booked == false && timeslot.bookings.present?
          timeslot.schedule_book_and_save
        end
      end
    end
  end

  desc "Update member fruits (give and take)"
  task :give_fruits_to_members => :environment do
    if Date.today == Date.today.end_of_month

      # decay fruit
      Fruitbasket.all.each do |basket|
        basket.decay
      end      


      # give fruit
      User.where(:status => "active").each do |user|
        puts user.firstname

        user.monthly_fruits.times do |t|
          Fruit.create(:user_id => user.id, :fruitbasket_id => user.fruitbasket.id)      
        end
      end

    end
  end

  desc "Create timeslots"
  task :create_timeslots => :environment do

    if Date.today.day == 15
      Time.zone = 'Copenhagen'

      Resource.all.each do |resource|
        begin_date = Date.today.beginning_of_week
        begin_time = "8:00:00".to_time
        end_time = "22:00:00".to_time
        
        current_date = begin_date
        90.times do |count|
          puts current_date
          current_time = begin_time
          while current_time < end_time do
            
            # see if timeslot exist
            t = Timeslot.find_by_resource_id_and_startdate_and_starttime(resource.id, current_date, current_time)

            # if it does not exist, then create and give parameters
            unless t
              t = Timeslot.new(:resource_id => resource.id, :startdate => current_date, :starttime => current_time)
              t.duration = resource.duration
              t.day = current_date.wday
              t.is_recurring = false
              t.booked = false
              t.save!
            end
            current_time = current_time + resource.duration.hours
          end
          current_date = current_date + 1.days
        end
      end

      # make sure all new timeslots is booked for users with recurring bookings
      begin_date = Date.today.beginning_of_week
      future_timeslots = Timeslot.where('startdate >= ?', begin_date)
      
      RecurringBooking.all.each do |r|        
        make_recurring = future_timeslots.where(:resource_id => r.resource_id, :day => r.day, :starttime => r.time)
        for timeslot in make_recurring
          if timeslot.current_booking
            # obs: right now the fruits will disappear
            timeslot.current_booking.destroy
          end

          timeslot.booked = true
          timeslot.is_recurring = true
          timeslot.save!
        end
      end      

      # Delete old timeslots
      history_date = Date.today - 60
      for timeslot in Timeslot.where("startdate < ?", history_date)
        timeslot.destroy
      end

    end
  end


  desc "Set/reset membership types"
  task :reset_memberships => :environment do

    for user in User.where('status <> ?', 'passive')
      if user.subscription.present?
        user.membership_id = user.subscription.plan.membership.id
      else
        if user.status == 'active' or user.status == 'pending'
          user.membership_id = Membership.find_by_name('BASIS').id
        elsif user.status == 'support'
          user.membership_id = Membership.find_by_name('SUPPORTER').id
        end
      end
      user.save!
    end
  end


end