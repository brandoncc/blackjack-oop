class Player
  attr_accessor :hand

  def initialize

  end

  def hit

  end

  def stay

  end

  def play_hand

  end

  def remove_hand

  end

  def say_stats

  end

  def hand

  end
end

class Dealer < Player
  def initialize

  end

  def deal

  end
end

class Card
  def initialize

  end
end

class Deck
  def initialize

  end

  def deal

  end

  def shuffle

  end
end

class Hand
  def initialize

  end

  def hit

  end

  def is_blackjack?

  end

  def is_bust?

  end
end

class Blackjack
  def initialize

  end

  def start_game

  end

  def greet_player

  end

  def player_turn

  end

  def dealer_turn

  end

  def compare_scores

  end

  def announce_winner

  end
end

Blackjack.new.start_game