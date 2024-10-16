# Iteration 3: Play the Game!
In this iteration, I am setting up the game to be playable. The goal is to write a runner file that serves as the entry point for the program and runs the game from the command line. The runner file will handle creating the deck of cards, dividing the cards between two players, and starting the game.

## Objective
- Create a game that can be played by generating a standard deck of cards, splitting them into two decks, and having two players battle until one player wins.
- Ensure that everything runs smoothly, including proper text outputs for each turn, and that nothing in this iteration breaks previous iterations.
## Key Points:
- I will use p to display output to the user.
- I'll create a "runner" file to serve as the main entry point to the game.
- Nothing in this iteration should break previous iterations.

## Step-by-Step Process

### 1. Create the Runner File
The runner file was created with the following command:
```ruby
touch war_or_peace_runner.rb
```
- This file will act as the main entry point for the game.
### 2. Implementing the Runner Code
#### The runner file contains code that:

- Generates a standard 52-card deck.
- Shuffles the deck and splits it between two players.
- Initializes a game where players take turns until a winner is determined.

```` ruby
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

# Create 52 cards
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

## Testing & Debugging

### Successes:
- The runner file was successfully created, and the game logic was correctly implemented to run on the command line.
- Both players received shuffled decks, and the game functioned as expected.
- Turn logic worked as expected, including handling **basic**, **war**, and **mutually_assured_destruction** turns.

### Challenges Encountered:
- **Edge Case Handling**: Initially, I noticed that in some cases where players had fewer than three cards, the game was breaking due to an error in the **war** or **mutually_assured_destruction** turn. This was resolved by adding a condition to check if both players had enough cards before proceeding with these types of turns.
```` ruby
# Before comparing the third card in war_turn?, ensure both players have enough cards
def war_turn?
  player1.deck.cards.length >= 3 && player2.deck.cards.length >= 3 &&
  player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
  player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
end
````
- **Game Length:** I had to include a maximum turn count of 1,000,000 turns to prevent the game from running indefinitely in case of certain card combinations leading to repetitive turns.
## Conclusion
Iteration 3 successfully set up the game to be played interactively. With the runner file, I can now run the game, create decks, and simulate multiple turns until one player wins or the game ends in a draw.

All tests for **Iterations 1** and **2** continue to pass, ensuring that no previous functionality was broken during this iteration.
