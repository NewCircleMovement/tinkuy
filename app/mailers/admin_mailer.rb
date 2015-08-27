class AdminMailer < ActionMailer::Base
  default from: "info@tinkuy.dk"

  def new_user(user)
  	@user = user
  	@recipients

		mail(to: 'medlem@tinkuy.dk', subject: 'New Tinkuy member!')
#  	for admin in User.where(:admin_info => true)
#  		mail(to: admin.email, subject: 'New Tinkuy member!')
#  	end
  end

  def membership_change(user, plan)
  	@user = user
  	@plan = plan

		mail(to: 'medlem@tinkuy.dk', subject: 'Tinkuy user membership change')
#  	for admin in User.where(:admin_info => true)
#  		mail(to: admin.email, subject: 'Tinkuy user membership change')
#  	end
  end

end
