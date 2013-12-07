# dealer class
class Dealer
  attr_accessor :deck, :hand

  def initialize
    @hand = Hand.new
    @has_blackjack = false
  end
end
