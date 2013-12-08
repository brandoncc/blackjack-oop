# Player class for blackjack game
class Player
  attr_accessor :hand, :name, :hands

  # @param [String] name
  def initialize(name = nil)
    @name  = name
    @hands = [Hand.new]
    @stats = { wins: 0, losses: 0, pushes: 0 }
  end

  def first_game?
    @stats[:wins].zero? && @stats[:losses].zero? && @stats[:pushes].zero?
  end

  def lost!
    puts 'You lost, sorry.'
    @stats[:losses] += 1
  end

  def won!
    puts 'You win, congratulations!'
    @stats[:wins] += 1
  end

  def pushed!
    puts 'This hand was a push. Some would say that is better than a loss.'
    @stats[:pushes] += 1
  end

  def busted
    puts "#{name}, you busted."
    lost!
  end

  def hit_blackjack
    puts "#{name}, you got blackjack, you win!"
    @stats[:wins] += 1
  end

  def choose_action
    show_action_options
    input = gets.chomp

    until %w(h s).include?(input.downcase)
      input = gets.chomp
      puts "I'm sorry, '#{input}' is not a valid option."
      puts ''
      show_action_options
    end

    input
  end

  def show_action_options
    puts ''
    puts '=> What would you like to do?'
    puts '=> Valid choices are (h) hit or (s) stay.'
  end

  def remove_hand
  end

  def say_stats
    puts "\nHere are your current stats:" +
             "#{@stats[:wins]} wins, " +
             "#{@stats[:losses]} losses, " +
             "#{@stats[:pushes]} pushes\n"
  end

  def hand
    @hands.first
  end
end
