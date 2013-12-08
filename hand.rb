class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def hit

  end

  def is_blackjack?
    cards.count == 2 && calculate_value[:value] == 21
  end

  def is_bust?
    calculate_value[:value] > 21
  end

  def announce_cards
    if @cards.count == 2 && (@cards.first.hidden || @cards.last.hidden)
      "Showing #{first_not_hidden_card.value} of #{first_not_hidden_card.suit}"
    else
      card_strings_array = []
      @cards.each { |card| card_strings_array << "#{card.value} of #{card.suit}" }
      card_strings_array <<
          "For a total value of: #{calculate_value[:soft_or_hard].nil? ? '' : "#{calculate_value[:soft_or_hard]} " }#{calculate_value[:value]}."

      card_strings_array.join("\n")
    end
  end

  # @return [Card]
  def first_not_hidden_card
    @cards.each do |card|
      unless card.hidden
        return card
      end
    end
  end

  def calculate_value
    score      = { value: 0, soft_or_hard: nil }
    aces_count = 0

    @cards.each do |card|
      if card.score_value == 11
        aces_count += 1
      else
        score[:value] += card.score_value.to_i
      end
    end

    calculate_aces(score, aces_count)

  end

  # @param [Hash] current_score
  # @param [Fixnum] count
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
    current_score[:soft_or_hard] = nil if current_score[:value] > 20
    current_score
  end
end
