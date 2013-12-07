# card class
class Card
  attr_accessor :suit, :value, :hidden

  def initialize(v, s)
    @value = v
    @suit = s
    @hidden = false
  end

  def to_s
    "#{@value} of #{@suit}"
  end

  def value
    if @value == 'Ace'
      11
    elsif @value.to_i == 0 && @value != 'Ace'
      10
    else
      @value.to_i
    end
  end
end
