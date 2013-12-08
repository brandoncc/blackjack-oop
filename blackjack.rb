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
      unless player_turn == :no_dealer_turn
        dealer_turn
      end
      announce_winner
      discard_cards
    end
  end

  def discard_cards
    [@player, @dealer].each do |e|
      while e.hand.cards.count > 0
        @deck.discard_pile << e.hand.cards.shift
      end
    end
  end

  def play_again?
    unless @player.first_game?
      loop do
        puts 'Would you like to play again?'

        case gets.chomp.downcase
          when 'y', 'yes'
            return true
          when 'n', 'no'
            return false
        end
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
    puts @dealer.hand.announce_cards
    puts ''
    puts 'Your cards:'
    puts @player.hand.announce_cards
  end

  def player_turn
    @player.hands.count.times do
      until @player.hand.is_blackjack? || @player.hand.is_bust?
        tell_cards_in_hands

        case @player.choose_action
          when 'h'
            @player.hand.cards << @deck.deal
          else
            break
        end
      end
    end

    :no_dealer_turn if @player.hand.is_blackjack? || @player.hand.is_bust?
  end

  def dealer_turn
    @dealer.hand.cards.each { |card| card.hidden = false }
    until @dealer.hand.calculate_value[:value] > 17
      @dealer.hand.cards << @deck.deal
    end
  end

  def compare_scores
    case @player.hand.calculate_value[:value] <=> @dealer.hand.calculate_value[:value]
      when -1
        @player.lost!
      when 0
        @player.pushed!
      when 1
        @player.won!
    end
  end

  def announce_winner
    someone_hit_or_bust = false
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
    dealer_hit_or_bust = false
    if @dealer.hand.is_bust?
      "Dealer busted, you win!"
      @player.won!
    end
    if @dealer.hand.is_blackjack?
      'Dealer got blackjack, you lose.'
      @player.lost!
    end

    @dealer.hand.is_bust? || @dealer.hand.is_blackjack?
  end
end
