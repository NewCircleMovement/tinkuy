class PagesController < ApplicationController

  def index

  end

  def info
  end

  def faq
  end

  def behandler
  end

  def bliv_medlem
    @basis_and_weekend_memberships = Membership.where('name=? or name=?', 'HVERDAGS', 'WEEKEND')
  end

end
