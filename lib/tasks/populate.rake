namespace :tinkuy do
	desc "Erase and fill database" 
	task :populate => :environment do
		Time.zone = 'Copenhagen'
		tempdate07 = DateTime.now.change({hour:7, min: 0})
		tempdate15 = DateTime.now.change({hour:15, min: 30})
		tempdate18 = DateTime.now.change({hour:18, min: 30})

		#eftermiddag
		Event.create(:name=>"Yoga", :description=>"lorum ipsom", :starttime=>tempdate15)
		Event.create(:name=>"Kimpro", :description=>"lorum ipsom", :starttime=>tempdate15 + 1)
		Event.create(:name=>"Hjertebrydning", :description=>"lorum ipsom", :starttime=>tempdate15 + 2)
		Event.create(:name=>"Inner Fitness", :description=>"lorum ipsom", :starttime=>tempdate15 + 3)

		#aften
		Event.create(:name=>"aften1", :description=>"lorum ipsom", :starttime=>tempdate18)
		Event.create(:name=>"aften2", :description=>"lorum ipsom", :starttime=>tempdate18 + 1)
		Event.create(:name=>"aften3", :description=>"lorum ipsom", :starttime=>tempdate18 + 2)
		Event.create(:name=>"aften4", :description=>"lorum ipsom", :starttime=>tempdate18 + 3)		
		Event.create(:name=>"koncert", :description=>"lorum ipsom", :starttime=>tempdate18 + 4)
		Event.create(:name=>"oplæsning", :description=>"lorum ipsom", :starttime=>tempdate18 + 5)
		Event.create(:name=>"foredrag", :description=>"lorum ipsom", :starttime=>tempdate18 + 6)
		Event.create(:name=>"brainstorm", :description=>"lorum ipsom", :starttime=>tempdate18 + 7)
		Event.create(:name=>"meditation", :description=>"lorum ipsom", :starttime=>tempdate18 + 8)
		Event.create(:name=>"cirkeldans", :description=>"lorum ipsom", :starttime=>tempdate18 + 9)
		Event.create(:name=>"lyrik", :description=>"lorum ipsom", :starttime=>tempdate18 + 10)
		Event.create(:name=>"kunstaften", :description=>"lorum ipsom", :starttime=>tempdate18 + 11)		
		Event.create(:name=>"malerier", :description=>"lorum ipsom", :starttime=>tempdate18 + 12)
		Event.create(:name=>"filmaften", :description=>"lorum ipsom", :starttime=>tempdate18 + 13)

		# meditation
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 1)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 2)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 3)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 4)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 5)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 6)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 7)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 8)
		Event.create(:name=>"Meditation", :description=>"lorum ipsom", :starttime=>tempdate07 + 9)


	end
end