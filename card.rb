# Card class for blackjack game
class Card
  attr_accessor :hidden
  attr_reader :suit, :value

  # @param [String] value
  # @param [String] suit
  def initialize(value, suit)
    @value  = value
    @suit   = suit
    @hidden = false
  end

  def score_value
    case @value.to_i
    when 0
      if @value == 'Ace'
        11
      else
        10
      end
    else
      @value.to_i
    end
  end
end
