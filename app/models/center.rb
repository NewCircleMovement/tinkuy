class Center < ActiveRecord::Base

  has_many :memberships

  def places_left(membership, user=nil)
    result = -1

    if membership.max_members != nil
      result = [membership.max_members - User.where(:membership_id => membership.id).length, 0].max
    else
      add_extra_space = 0
      
      basis = Membership.find_by_name('HVERDAGS')
      weekend = Membership.find_by_name('WEEKEND')

      if user
        if user.membership.present?
          if ['HVERDAGS', 'WEEKEND'].include? user.membership.name
            add_extra_space = 1
          end
        end
      end

      result = [ self.places_left(basis), self.places_left(weekend) ].min + add_extra_space
    end

    return result
  end

end
