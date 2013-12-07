# hand class
class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def calculate_value
    score      = { value: 0, soft_or_hard: nil }
    aces_count = 0

    @cards.each do |card|
      if card.value == 11
        aces_count += 1
      else
        score[:value] += card.value
      end
    end

    calculate_aces(score, aces_count)
  end

  def calculate_aces(current_score, count)
    # If any items are in the ace array, calculate them in based on whether they
    #   need to be 11 points or 1 point. 11 points is preferred, unless it will
    #   cause a bust, in which case, calculate it as 1 point.
    i = 0
    while i < count do
      if (current_score[:value] + 11) > 21
        current_score[:value] += 1
        current_score[:soft_or_hard] = 'hard' if i == 0
      else
        current_score[:value] += 11
        current_score[:soft_or_hard] = 'soft' if i == 0
      end
      i += 1
    end

    current_score
  end
end
