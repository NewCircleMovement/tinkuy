class AdminMailer < ActionMailer::Base
  default from: "info@tinkuy.com"

  def new_user(user)
  	@user = user
  	@recipients
  	mail(to: 'kbjerring@gmail.com', subject: 'New Tinkuy member!')
  end

  def membership_change(user, plan)
  	@user = user
  	@plan = plan
  	mail(to: 'kbjerring@gmail.com', subject: 'Tinkuy user membership change')
  end

end
