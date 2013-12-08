require 'pry'

class Player
  attr_accessor :hand, :name, :hands

  # @param [String] name
  def initialize(name = nil)
    @name  = name
    @hands = [Hand.new]
  end

  def hit

  end

  def stay

  end

  def choose_action
    show_action_options
    input = gets.chomp

    until ['h', 's'].include?(input.downcase)
      input = gets.chomp
      puts "I'm sorry, '#{input}' is not a valid option."
      puts ''
      show_action_options
    end

    input
  end

  def show_action_options
    puts '=> What would you like to do?'
    puts 'Valid choices are (h) hit or (s) stay.'
    puts ''
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
  # @param [Deck] deck_for_dealing
  # @param [Player] player
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

  # @param [String] value
  # @param [String] suit
  def initialize(value, suit)
    @value = value
    @suit  = suit
    @hidden = false
  end

  def score_value
    case @value.to_i
      when 0
        if @value == 'Ace'
          11
        else
          10
        end
      else
        @value.to_i
    end
  end
end

class Deck
  # @param [Fixnum] how_many_decks
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
      card_strings_array <<
          "For a total value of: #{calculate_value[:soft_or_hard].nil? ? '' : "#{calculate_value[:soft_or_hard]} " }#{calculate_value[:value]}."

      card_strings_array.join("\n")
    end
  end

  # @return [Card]
  def first_not_hidden_card
    @cards.each do |card|
      unless card.hidden
        return card
      end
    end
  end

  def twenty_one_or_bust
    return 'test'
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
    # If any items are in the ace array, calculate them in based on whether they
    #   need to be 11 points or 1 point. 11 points is preferred, unless it will
    #   cause a bust, in which case, calculate it as 1 point.
    i = 0
    while i < count do
      if (current_score[:value] + 11) > 21
        current_score[:value] += 1
        current_score[:soft_or_hard] = 'hard' if i == 0
      else
        current_score[:value] += 11
        current_score[:soft_or_hard] = 'soft' if i == 0
      end
      i += 1
    end

    current_score
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
    @player.hands.count.times do
      until @player.hand.is_blackjack? || @player.hand.is_bust?
        tell_cards_in_hands

        case @player.choose_action
          when 'h'
            @player.hand.cards << @deck.deal
            @player.hand.twenty_one_or_bust
          else
            break
        end
      end
    end
  end

  def dealer_turn

  end

  def compare_scores

  end

  def announce_winner

  end
end

Blackjack.new.start_game