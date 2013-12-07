require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'

class Blackjack
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck   = Deck.new

    loop do
      puts ''
      puts 'Would you like to play (h) home rules or (v) rules?'
      game_type = gets.chomp

      case game_type.downcase
        when 'h'
          play_home_rules
          break
        when 'v'
          puts 'Sorry, this feature is not included in this version.'
          # TODO: break (after feature is implemented)
        else
          puts "Sorry, '#{game_type}' is not a valid option."
      end
    end
  end

  def play_home_rules
    puts 'You chose home rules.'
  end

  def play_vegas_rules
    puts 'You chose Vegas rules.'
  end
end