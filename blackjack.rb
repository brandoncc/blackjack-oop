require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'

# blackjack game class

class Blackjack
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck   = Deck.new(6)
    loop do
      puts ''
      puts 'Would you like to play (h) home rules or (v) rules?'
      game_type = gets.chomp
      break if choose_game_type(game_type) == 'valid'
    end
  end

  def play_home_rules
    puts 'You chose home rules.'
  end

  def play_vegas_rules
    puts 'You chose Vegas rules.'
  end

  # Be sure to return valid at the end of code when player chooses a
  # valid game type.
  def choose_game_type(t)
    if t.downcase == 'h'
      play_home_rules
      'valid'
    elsif t.downcase == 'v'
      puts 'Sorry, this feature is not included in this version.'
      'invalid'
      # TODO: return 'valid' (after feature is implemented)
    else
      puts "Sorry, '#{t}' is not a valid option."
      'invalid'
    end
  end
end
