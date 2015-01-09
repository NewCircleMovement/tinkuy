namespace :tinkuy do

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

  desc "Erase and fill database" 
  task :populate => :environment do
    Time.zone = 'Copenhagen'
    tempdate = Date.today.beginning_of_week
    temptime07 = "07:00"
    temptime15 = "15:30"
    temptime18 = "18:30"

    User.create(:email => "test@test.com", :encrypted_password => "12345678")

    #eftermiddag
    Event.create(:name=>"Kimpro", :description=>"lorum ipsom", :startdate=>tempdate, :starttime=>temptime15)
    Event.create(:name=>"Inner Fitness", :description=>"lorum ipsom", :startdate=>tempdate + 1, :starttime=>temptime15)
    Event.create(:name=>"Yoga", :description=>"lorum ipsom", :startdate=>tempdate + 2, :starttime => temptime15)
    Event.create(:name=>"Hjertebrydning", :description=>"lorum ipsom", :startdate=>tempdate + 3, :starttime => temptime15)

    #aften
    Event.create(:name=>"sharingcircle", :description=>"lorum ipsom", :startdate=>tempdate, :starttime=>temptime18)
    Event.create(:name=>"Open Space", :description=>"lorum ipsom", :startdate=>tempdate + 1, :starttime=>temptime18)
    Event.create(:name=>"Stand up", :description=>"lorum ipsom", :startdate=>tempdate + 2, :starttime=>temptime18)
    Event.create(:name=>"Evas nye koncept", :description=>"lorum ipsom", :startdate=>tempdate + 3, :starttime=>temptime18)
    Event.create(:name=>"koncert", :description=>"lorum ipsom", :startdate=>tempdate + 4, :starttime=>temptime18)
    Event.create(:name=>"oplæsning", :description=>"lorum ipsom", :startdate=>tempdate + 5, :starttime=>temptime18)
    Event.create(:name=>"foredrag", :description=>"lorum ipsom", :startdate=>tempdate + 6, :starttime=>temptime18)
    Event.create(:name=>"brainstorm", :description=>"lorum ipsom", :startdate=>tempdate + 7, :starttime=>temptime18)
    Event.create(:name=>"meditation", :description=>"lorum ipsom", :startdate=>tempdate + 8, :starttime=>temptime18)
    Event.create(:name=>"cirkeldans", :description=>"lorum ipsom", :startdate=>tempdate + 9, :starttime=>temptime18)
    Event.create(:name=>"lyrik", :description=>"lorum ipsom", :startdate=>tempdate + 10, :starttime=>temptime18)
    Event.create(:name=>"kunstaften", :description=>"lorum ipsom", :startdate=>tempdate + 11, :starttime=>temptime18)   
    Event.create(:name=>"malerier", :description=>"lorum ipsom", :startdate=>tempdate + 12, :starttime=>temptime18)
    Event.create(:name=>"filmaften", :description=>"lorum ipsom", :startdate=>tempdate + 13, :starttime=>temptime18)

    # meditation
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 1, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 2, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 3, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 4, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 5, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 6, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 7, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 8, :starttime=>temptime07)
    Event.create(:name=>"Meditation", :description=>"lorum ipsom", :startdate=>tempdate + 9, :starttime=>temptime07)
  end
end