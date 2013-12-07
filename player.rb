# player class
class Player
  attr_accessor :name, :hands

  def initialize
    puts 'Hello, what is your name?'

    input = gets.chomp
    while input.length.zero?
      puts "I'm sorry, I didn't get that."
      input = gets.chomp
    end
    @name = input

    puts "Nice to meet you, #{name}"

    @hands = [Hand.new]
    @has_blackjack = false
  end

  def hand
    hands.first
  end

  def has_blackjack?

  end
end
