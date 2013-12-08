require_relative 'player'

class Dealer < Player
  # @param [Deck] deck_for_dealing
  # @param [Player] player
  def initialize(deck_for_dealing, player)
    super('Dealer')
    @deck     = deck_for_dealing
    @opponent = player
  end

  def deal
    2.times do
      @opponent.hand.cards << @deck.deal
      hand.cards << @deck.deal
    end

    hand.cards.last.hidden = true
  end
end
