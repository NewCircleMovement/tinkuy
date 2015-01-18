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

  desc "Give fruits to members"
  task :give_fruits_to_members => :environment do
    if Date.today == Date.today.end_of_month
      User.where(:status => "active").each do |user|
        puts user.firstname
        100.times do |t|
          Fruit.create(:user_id => user.id, :fruitbasket_id => user.fruitbasket.id)      
        end
      end
    end
  end

  desc "Create timeslots"
  task :timeslots => :environment do
    Time.zone = 'Copenhagen'

    Resource.all.each do |resource|
      begin_date = Date.today
      begin_time = "8:00:00".to_time
      end_time = "22:00:00".to_time

      current_date = begin_date
      7.times do |count|
        puts current_date
        current_time = begin_time
        while current_time < end_time do
          t = Timeslot.find_or_create_by_resource_id_and_startdate_and_starttime(resource.id, current_date, current_time)
          t.duration = resource.duration
          unless t.booked == true
            t.booked = false
          end
          t.save!
          current_time = current_time + resource.duration.hours
        end
        current_date = current_date + 1.days
      end

      if resource.name == 'Arbejdsrum'
        resource.timeslots.each do |t|
          if [1,2].include? t.startdate.wday
            t.destroy
          end
        end
      end

    end
  end
end