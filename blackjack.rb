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

  def deal_cards
    2.times do
      @dealer.hand.cards << @deck.shuffled_cards.shift
      @player.hand.cards << @deck.shuffled_cards.shift
    end
    @dealer.hand.cards.last.hidden = true
  end
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

  def print_cards(name, hand)
    if name.downcase == 'dealer'
      puts "#{name.capitalize} has:"
    elsif name.downcase == 'player' || name.downcase == 'you'
      puts 'You have:'
    end

    hand.cards.each { |card| puts card.hidden ? '*hidden*' : card.to_s }

    puts "For a total of #{hand.calculate_value[:value]} points." if name.downcase != 'dealer'
  end
end
