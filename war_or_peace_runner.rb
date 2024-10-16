require_relative './lib/card'
require_relative './lib/deck'
require_relative './lib/player'
require_relative './lib/turn'

# Create 52 cards for a standard deck
ranks = (2..14).to_a
suits = [:heart, :diamond, :club, :spade]
values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

cards = []
suits.each do |suit|
  ranks.each_with_index do |rank, index|
    cards << Card.new(rank, suit, values[index])
  end
end

# Shuffle the deck of cards
shuffled_deck = cards.shuffle

# Split the deck into two decks for the two players
deck1 = Deck.new(shuffled_deck[0..25])
deck2 = Deck.new(shuffled_deck[26..51])

# Create two players with the shuffled decks
player1 = Player.new("Qoiree", deck1)
player2 = Player.new("Scarlett", deck2)

# Define the game class
class Game
  # Initialize the game with two players and a turn count
  def initialize(player1, player2)
    @player1 = player1   # Assign the player1 passed from the runner file
    @player2 = player2   # Assign the player2 passed from the runner file
    @turn_count = 0      # Initialize the turn count to 0
  end

  # Method to start the game
  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{@player1.name} and #{@player2.name}."
    p "Type 'GO' to start the game!"
    input = gets.chomp
    if input != 'GO'
      p "Invalid input. Type 'GO' to start the game!"
      return
    end

    # Continue playing until one player has lost or 1,000,000 turns have passed
    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      turn = Turn.new(@player1, @player2)
      turn_type = turn.type
      winner = turn.winner

      if turn_type == :mutually_assured_destruction
        p "Turn #{@turn_count}: *Mutually assured destruction* 6 cards removed from play"
        turn.pile_cards
      elsif turn_type == :war
        p "Turn #{@turn_count}: WAR - #{winner.name} won 6 cards"
        turn.pile_cards
        turn.award_spoils(winner)
      else
        p "Turn #{@turn_count}: #{winner.name} won 2 cards"
        turn.pile_cards
        turn.award_spoils(winner)
      end

      @turn_count += 1
