class RegistrationsController < Devise::RegistrationsController
  before_filter :check_if_full

  def check_if_full
    if @places_left <= 0
      redirect_to root_url, :notice => "Der er ingen pladser tilbage"
    end
  end

end