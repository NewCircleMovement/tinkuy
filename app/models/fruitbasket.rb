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
    # pick oldest fruits
    fruits = self.fruits(:order => 'created_at asc').limit(number)
    puts "number of fruits to give: #{fruits.count}"
    receiver_basket.fruits << fruits
    receiver_basket.fruits(:order => 'created_at asc')
    
    # update counter cache
    self.fruits_count = self.fruits_count - number
    receiver_basket.fruits_count = receiver_basket.fruits_count + number

    # save baskets
    self.save!
    receiver_basket.save!
  end

end
