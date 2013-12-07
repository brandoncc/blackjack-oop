# deck class
class Deck
  attr_accessor :discard_pile, :shuffled_cards

  def initialize(how_many_decks)
    @shuffled_cards = []
    @discard_pile   = []

    how_many_decks.times do
      %w(Clubs Diamonds Hearts Spades).each do |s|
        %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).each do |v|
        end
      end
    end

    15.times { @shuffled_cards.shuffle! }
  end
end
