# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string(255)
#  surname                :string(255)
#  confirm_payment        :boolean          default(FALSE)
#  status                 :string(50)       default("pending")
#  admin                  :boolean          default(FALSE)
#  membertype             :integer
#  membership_id          :integer
#  admin_info             :boolean          default(FALSE)
#

class UsersController < ApplicationController
  
  def index
    @confirmed_users = User.where(:status => 'active').order(:firstname, :surname)
    @pending_users = User.where(:status => 'pending').order(:firstname, :surname)
  end

  def events
  	@user = User.find(params[:user_id])
  	@events = @user.events.order(startdate: :desc)
  end

end
