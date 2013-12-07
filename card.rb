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
end
