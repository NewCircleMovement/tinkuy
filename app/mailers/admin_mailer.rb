class AdminMailer < ActionMailer::Base
  default from: "info@tinkuy.com"

  def new_user(user)
  	@user = user
  	@recipients

  	for admin in User.where(:admin_info => true)
  		mail(to: admin.email, subject: 'New Tinkuy member!')
  	end
  end

  def membership_change(user, plan)
  	@user = user
  	@plan = plan

  	for admin in User.where(:admin_info => true)
  		mail(to: admin.email, subject: 'Tinkuy user membership change')
  	end
  end

end
