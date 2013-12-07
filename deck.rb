# deck class
class Deck
  attr_accessor :discard_pile, :shuffled_cards

  def initialize(how_many_decks)
    @shuffled_cards = []
    @discard_pile = []

    %w(Clubs, Diamonds, Hearts, Spades).each do |s|
      %w(2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace).each do |v|
        @shuffled_cards << Card.new(v, s)
      end
    end

    @shuffled_cards *= how_many_decks
    15.times { @shuffled_cards.shuffle! }
  end
end
