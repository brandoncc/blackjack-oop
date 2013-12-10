# Hand class for blackjack game
class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def is_blackjack?
    cards.count == 2 && value == 21
  end

  def is_bust?
    value > 21
  end

  def value
    calculate_value[:value]
  end

  def soft_or_hard
    calculate_value[:soft_or_hard]
  end

  def announce_cards
    if @cards.count == 2 && (@cards.first.hidden || @cards.last.hidden)
      showing_card
    else
      show_all_cards
    end
  end

  def showing_card
    "Showing #{first_not_hidden_card}"
  end

  def show_all_cards
    card_strings_array = []
    @cards.each do |card|
      card_strings_array <<
          "#{card}"
    end

    card_strings_array << 'For a total value of: ' +
        "#{soft_or_hard.nil? ? '' : "#{soft_or_hard} " }" + "#{value}."

    card_strings_array.join("\n")
  end

  # @return [Card]
  def first_not_hidden_card
    @cards.each do |card|
      return card unless card.hidden
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
    # If any items are in the ace array, calculate them in based on whether
    #   they need to be 11 points or 1 point. 11 points is preferred, unless it
    #   will cause a bust, in which case, calculate it as 1 point.
    i = 0
    while i < count
      add_ace_to_score(current_score, i == 0)

      i += 1
    end
    current_score[:soft_or_hard] = nil if current_score[:value] > 20
    current_score
  end

  def add_ace_to_score(score, set_soft_or_hard)
    if (score[:value] + 11) > 21
      score[:value] += 1
      score[:soft_or_hard] = 'hard' if set_soft_or_hard
    else
      score[:value] += 11
      score[:soft_or_hard] = 'soft' if set_soft_or_hard
    end
  end
end
