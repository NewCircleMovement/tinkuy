# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  amount     :integer
#  category   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bid < ActiveRecord::Base

	# TODO: validate uniquesss of PAIR of ids
	# validates :user_id, uniqueness: { scope: :event_id }
	# validates_uniqueness_of :user_id, :scope => [:event_id]

	belongs_to :event
	belongs_to :user

	def do_something
		puts "bidss ........................"
		# save
	end


end
