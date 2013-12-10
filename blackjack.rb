# Blackjack class
class Blackjack
  def initialize
    @deck   = Deck.new(6)
    @player = Player.new
    @dealer = Dealer.new(@deck, @player)
  end

  def start_game
    greet_player

    while play_again?
      deal_cards

      player_turn || dealer_turn

      announce_winner
      discard_cards
    end
  end

  def discard_cards
    [@player, @dealer].each do |e|
      @deck.discard_pile << e.hand.cards.shift while e.hand.cards.count > 0
    end
  end

  def play_again?
    unless @player.first_game?
      loop do
        puts 'Would you like to play again?'

        input = gets.chomp.downcase
        return true if %w(y yes).include?(input)
        return false if %w(n no).include?(input)
      end
    end

    # do not ask to "play again" on the first hand
    true
  end

  def greet_player
    puts '=> Hello, what is your name?'
    input = gets.chomp

    until input.length > 0
      puts "=> I'm sorry, what was that?"
      input = gets.chomp
    end

    puts "Nice to meet you, #{input}"
    @player.name = input
  end

  def deal_cards
    @dealer.deal
  end

  def tell_cards_in_hands
    puts "Dealer's cards:"
    puts "#{@dealer.hand}"
    puts ''
    puts 'Your cards:'
    puts "#{@player.hand}"
  end

  def player_turn
    @player.hands.count.times do
      until @player.hand.is_blackjack? || @player.hand.is_bust?
        tell_cards_in_hands

        action = @player.choose_action
        @player.hand.cards << @deck.draw if action == 'h' || break
      end
    end

    @player.hand.is_blackjack? || @player.hand.is_bust?
  end

  def dealer_turn
    @dealer.hand.cards.each { |card| card.hidden = false }
    @dealer.hand.cards << @deck.draw until @dealer.hand.value > 17
  end

  def compare_scores
    case @player.hand.value <=>
        @dealer.hand.value
    when -1
      @player.lost!
    when 0
      @player.pushed!
    when 1
      @player.won!
    end
  end

  def announce_winner
    tell_cards_in_hands

    someone_hit_or_bust = check_player_hit_or_bust unless someone_hit_or_bust
    someone_hit_or_bust = check_dealer_hit_or_bust unless someone_hit_or_bust

    compare_scores unless someone_hit_or_bust

    @player.say_stats
  end

  def check_player_hit_or_bust
    @player.busted if @player.hand.is_bust?
    @player.hit_blackjack if @player.hand.is_blackjack?

    @player.hand.is_bust? || @player.hand.is_blackjack?
  end

  def check_dealer_hit_or_bust
    if @dealer.hand.is_bust?
      puts 'Dealer busted, you win!'
      @player.won!
    end
    if @dealer.hand.is_blackjack?
      puts 'Dealer got blackjack, you lose.'
      @player.lost!
    end

    @dealer.hand.is_bust? || @dealer.hand.is_blackjack?
  end
end
