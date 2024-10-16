# War or Peace Game - Ruby Implementation

## Setup

To set up the game and its logic, we create the following classes: `Card`, `Deck`, `Player`, `Turn`, and a new `Game` class. We will also shuffle a standard deck of 52 cards and split them between two players.

## Code

```ruby
# Require the necessary files
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
player1 = Player.new("Player 1", deck1)
player2 = Player.new("Player 2", deck2)

# Define the game class
class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_count = 0
  end

  # Method to start the game
  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{@player1.name} and #{@player2.name}."
    p "Type 'GO' to start the game!"
    
    # Continue playing until one player has lost or 1,000,000 turns have passed
    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      turn = Turn.new(@player1, @player2)
      turn_type = turn.type
      winner = turn.winner

      if turn_type == :mutually_assured_destruction
        p "*Mutually assured destruction* 3 cards from each player removed from play"
        turn.pile_cards
      elsif turn_type == :war
        p "WAR - #{winner.name} won 6 cards"
        turn.pile_cards
        turn.award_spoils(winner)
      else
        p "#{winner.name} won 2 cards"
        turn.pile_cards
        turn.award_spoils(winner)
      end

      @turn_count += 1
    end

    if @player1.has_lost?
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.has_lost?
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    else
      p "---- DRAW ----"
    end
  end
end

# Start the game
game = Game.new(player1, player2)
game.start
````
##  Explanation:
1. **Card Creation:**  I first created 52 cards, representing a standard deck, with suits and ranks.

2. **Decks and Players:** The cards are shuffled and split into two decks, each given to a player.

3. **Game Logic:** The `Game` class initializes with two players. The `start` method manages the game flow, handling turn logic for basic, war, and mutually assured destruction turns.

4. **Win Condition:**  The game continues until one player loses all their cards, or until 1,000,000 turns have passed, at which point a draw is declared.