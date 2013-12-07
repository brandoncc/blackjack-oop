require 'pry'

class Player
  attr_accessor :hand, :name

  def initialize(name = nil)
    @name  = name
    @hands = [Hand.new]
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
    @hands.first
  end
end

class Dealer < Player
  def initialize(deck_for_dealing, player)
    super('Dealer')
    @deck     = deck_for_dealing
    @opponent = player
  end

  def deal
    2.times do
      @opponent.hand.cards << @deck.deal
      hand.cards << @deck.deal
    end

    hand.cards.last.hidden = true
  end
end

class Card
  attr_accessor :hidden
  attr_reader :suit, :value

  def initialize(value, suit)
    @value = value
    @suit  = suit
    @hidden = false
  end
end

class Deck
  def initialize(how_many_decks)
    @shuffled_cards = []
    @discard_pile   = []

    how_many_decks.times do
      %w(Clubs Diamonds Hearts Spades).each do |s|
        %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).each do |v|
          @shuffled_cards << Card.new(v, s)
        end
      end
    end

    shuffle_deck!
  end

  def deal
    shuffle_deck! if @shuffled_cards.count == 0
    @shuffled_cards.shift
  end

  def shuffle_deck!
    @discard_pile.count.times do
      @shuffled_cards << @discard_pile.pop
    end

    15.times do
      @shuffled_cards.shuffle!
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def hit

  end

  def is_blackjack?

  end

  def is_bust?

  end

  def announce_cards
    if @cards.count == 2 && (@cards.first.hidden || @cards.last.hidden)
      "Showing #{first_not_hidden_card.value} of #{first_not_hidden_card.suit}"
    else
      card_strings_array = []
      @cards.each { |card| card_strings_array << "#{card.value} of #{card.suit}" }

      card_strings_array.join("\n")
    end
  end

  def first_not_hidden_card
    @cards.each do |card|
      unless card.hidden
        return card
      end
    end
  end
end

class Blackjack
  def initialize
    @deck   = Deck.new(6)
    @player = Player.new
    @dealer = Dealer.new(@deck, @player)
  end

  def start_game
    greet_player
    deal_cards
    player_turn
    #dealer_turn
    #compare_scores
    #announce_winner
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
    tell_cards_in_hands
  end

  def dealer_turn

  end

  def compare_scores

  end

  def announce_winner

  end
end

Blackjack.new.start_game