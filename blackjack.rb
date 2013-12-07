require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'

class Blackjack
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck   = Deck.new
  end
end