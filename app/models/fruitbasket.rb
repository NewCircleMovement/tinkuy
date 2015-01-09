# == Schema Information
#
# Table name: fruitbaskets
#
#  id           :integer          not null, primary key
#  owner_id     :integer
#  owner_type   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  fruits_count :integer          default(0)
#

class Fruitbasket < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_many :fruits, :dependent => :destroy

  # TODO: når vi sletter en booking, så skal frugterne tilbage til brugeren inden den bliver slettet
  # TODO: vi skal have en slags "time index" så frugterne altid ligger i kronologisk orden

  def give_fruits_to(receiver_basket, number)
    fruits = self.fruits(:order => 'created_at asc').limit(number)
    receiver_basket.fruits << fruits
    receiver_basket.fruits(:order => 'created_at asc')
    
    self.update_counter_cache(-number)
    receiver_basket.update_counter_cache(number)
  end

  def update_counter_cache(number)
    self.fruits_count = self.fruits_count + number
    self.save!
  end

end
