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

DECAY_RATE = 0.1

class Fruitbasket < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_many :fruits, :dependent => :destroy

  # TODO: når vi sletter en booking, så skal frugterne tilbage til brugeren inden den bliver slettet
  # TODO: vi skal have en slags "time index" så frugterne altid ligger i kronologisk orden

  def give_fruits_to(receiver_basket, number)

    # giving fruitbasket kan only give the amount it contains
    if number > self.fruits.counts
      number = self.fruits.counts
    end

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

  def decay
    count = fruits.count
    if count > 0
      decay_count = [(count * DECAY_RATE).to_i, 1].max
      self.fruits.limit(decay_count).destroy_all
      self.fruits_count = fruits.count
      self.save!
    end
  end


end
