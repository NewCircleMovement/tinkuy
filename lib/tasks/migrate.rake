namespace :migrate do

  task :reset_fruits => :environment do

    # delete all fruits
    puts "Deleting fruits..."
    for fruit in Fruit.all do
      fruit.destroy
    end

    # delete all fruitbaskets
    puts "Deleting fruit baskets..."
    for basket in Fruitbasket.all do
      basket.destroy
    end

    # delete all bookings
    puts "Deleting bookings..."
    for booking in Booking.all do
      booking.destroy
    end

    puts "Generating baskets and fruits for users..."
    User.all.each do |user|
      puts user.firstname
      basket = Fruitbasket.create(:owner_id => user.id, :owner_type => 'User')
      100.times do |t|
        Fruit.create(:user_id => user.id, :fruitbasket_id => basket.id)
      end    
    end

    puts "Generating baskets and fruits for evnets..."
    Event.all.each do |event|
      puts event.name
      basket = Fruitbasket.create(:owner_id => event.id, :owner_type => 'Event')
    end

    puts "Resetting counter cache..."
    for basket in Fruitbasket.all
      Fruitbasket.reset_counters(basket.id, :fruits)
    end

    puts "antal frugtkurve: " + Fruitbasket.all.length.to_s
    puts "antal frugter: " + Fruit.all.length.to_s
    puts "antal brugere: " + User.all.length.to_s
    puts "antal events: " + Event.all.length.to_s
  end



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