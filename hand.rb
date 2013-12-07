# hand class
class Hand

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
end
