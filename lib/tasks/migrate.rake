namespace :migrate do

  task :reset_counters => :environment do 
    for fruitbasket in Fruitbasket.all
      Fruitbasket.reset_counters(fruitbasket.id, :fruits)
    end
  end
  
  task :give_me_fruit => :environment do
    u = User.find(20)
    100.times do |t|
      Fruit.create(:user_id => u.id, :fruitbasket_id => u.fruitbasket.id)      
    end
  end



  task :distribute_fruits => :environment do

    User.all.each do |user|
      puts user.firstname
      unless user.fruitbasket.present?
        f = Fruitbasket.create(:owner_id => user.id, :owner_type => 'User')
      else
        f = user.fruitbasket
      end
      user.fruits.where(:event_id => nil).each do |fruit|
        fruit.fruitbasket_id = f.id
        fruit.save
      end

      f.fruits_count = f.fruits.length
      f.save!
    end

    Event.all.each do |event|
      puts event.name
      unless event.fruitbasket.present?
        f = Fruitbasket.create(:owner_id => event.id, :owner_type => 'Event')
      else
        f = event.fruitbasket
      end
      if event.fruits.length > 0
        event.fruits.each do |fruit|
          fruit.fruitbasket_id = f.id
          fruit.save
        end
      end

      f.fruits_count = f.fruits.length
      f.save!
    end

  end

end