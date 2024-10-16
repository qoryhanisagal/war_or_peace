## War or Peace

This is the Qoiree for the SE Mod1 **War or Peace** project.

## Overview of the Project
"War or Peace" is a card game built in Ruby, simulating the classic card game War between two players. In this project, I've created a fully functional game using object-oriented principles, with tests in RSpec to ensure each part works properly. The game logic is split into different classes, representing components like cards, decks, players, and turns. I'll explain the syntax, logic, and testing behind each file, starting from the core classes in lib/ to the runner and spec files.

## Folder Structure
1. `lib` **folder:** Contains the core classes that define the game's functionality:
    - `card.rb`: Represents a playing card.
    - `deck.rb`: Manages a collection of cards.
    - `player.rb`: Manages players and their decks.
    - `turn.rb`: Handles the mechanics of each turn.
    - `game.rb`: Contains the main game logic.
2. `spec folder`: Contains the RSpec test files to test each class:
    - `card_spec.rb`, `deck_spec.rb`, `player_spec.rb`, `turn_spec.rb`: Test the respective classes.
    - `spec_helper.rb`: Configures the test environment.
3. `war_or_peace_runner.rb`: This is the main runner file that executes the game by initializing the decks and players, then starting the game.

## Detailed Explanation of Each File
1. `war_or_peace_runner.rb`
**Purpose:** This is the entry point of the game. It sets up the game by creating the deck of cards, shuffling them, and assigning the shuffled deck to each player. It then starts the game loop.

**Logic Breakdown:**

- First, it requires all the necessary class files (`card`, `deck`, `player`, `turn`, `game`).
- It creates a deck of 52 cards by looping through suits and ranks.
- The deck is shuffled, and then split evenly between two players.
- Finally, it instantiates the Game class and calls the start method to begin the game.

````ruby
require_relative './lib/card'
require_relative './lib/deck'
require_relative './lib/player'
require_relative './lib/turn'
require_relative './lib/game'

# Setup the game by creating and shuffling the deck
ranks = (2..14).to_a
suits = [:heart, :diamond, :club, :spade]
values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

cards = []
suits.each do |suit|
  ranks.each_with_index do |rank, index|
    cards << Card.new(rank, suit, values[index])
  end
end
shuffled_deck = cards.shuffle

# Split into two decks
deck1 = Deck.new(shuffled_deck[0..25])
deck2 = Deck.new(shuffled_deck[26..51])

# Create two players
player1 = Player.new("Qoiree", deck1)
player2 = Player.new("Scarlett", deck2)

# Start the game
game = Game.new(player1, player2)
game.start
````
- **Additional Debugging (if needed):** You can insert print statements like this to debug and check each player's shuffled deck:
```` ruby
# Print shuffled decks for debugging
p "Player 1 deck: #{deck1.cards.map(&:rank)}"
p "Player 2 deck: #{deck2.cards.map(&:rank)}"
````
2. `card.rb`

- **Purpose:** Represents a single card in the deck with attributes: `rank`, `suit`, and `value`.

- **Key Points:**

    - Cards are initialized with their rank (number), suit (e.g., hearts, spades), and value (e.g., "King").
    - This class is crucial since it defines the basic unit of the game—each card that players will compare in their turns.
````ruby
class Card
  attr_reader :rank, :suit, :value

  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end
end
````
3. `deck.rb`

Purpose: Manages a collection of Card objects.

Key Points:

The Deck class can return the rank of a card at a given index, remove a card, add a card, and calculate the percentage of high-ranking cards (rank >= 11).
This class interacts heavily with the Turn class, where cards are drawn, and it ensures that the player's deck is properly managed.
````ruby
class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index]&.rank || 0
  end

  def high_ranking_cards
    @cards.select { |card| card.rank >= 11 }
  end

  def percent_high_ranking
    return 0 if @cards.empty?
    (high_ranking_cards.count.to_f / @cards.count * 100).round(2)
  end

  def remove_card
    @cards.shift
  end

  def add_card(card)
    @cards.push(card)
  end
end
````
4. `player.rb`
- **Purpose:** Represents a player, who has a name and a deck of cards.

- **Key Points:**

  - The `Player` class is used to check if the player has lost (when their deck is empty), and to manage their name and deck.
  - Each turn interacts with the `Player` objects, checking for win conditions.

````ruby
class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    @deck.cards.empty?
  end
end
````
5. `turn.rb`
- **Purpose:** Handles the game logic for each turn.

- **Key Points:**

- The `Turn` class compares cards between two players and handles different scenarios:
    - **Basic:** When the top cards have different ranks.
    - **War:** When the top cards have the same rank.
    - **Mutually Assured Destruction:** When both the first and third cards are the same rank.
- The turn logic determines the winner, piles the cards, and awards the spoils of war.
````ruby
class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if basic_turn?
      :basic
    elsif war_turn?
      :war
    else
      :mutually_assured_destruction
    end
  end

  def winner
    case type
    when :basic
      basic_winner
    when :war
      war_winner
    else
      'No Winner'
    end
  end

  def pile_cards
    if type == :basic
      add_basic_cards_to_spoils
    elsif type == :war
      add_war_cards_to_spoils
    else
      remove_war_cards
    end
  end

  def award_spoils(winner)
    return if winner == 'No Winner'
    winner.deck.cards.concat(@spoils_of_war)
    @spoils_of_war.clear
  end
end
````
6. `game.rb`
- **Purpose:** Runs the overall game logic by managing the flow of turns and determining when the game ends.

- **Key Points:**

  - The `Game` class manages the flow of the game, asking players to start, then running turns until one player loses or a maximum of 1,000,000 turns have passed.
  - It handles printing the game results and prompts, managing the `Turn` class, and ensuring each player's deck is updated.
````ruby
class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_count = 0
  end

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{@player1.name} and #{@player2.name}."
    p "Type 'GO' to start the game!"
    input = gets.chomp
    return if input != 'GO'

    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      play_turn
    end
    end_game_message
  end

  def play_turn
    @turn_count += 1
    turn = Turn.new(@player1, @player2)
    turn.pile_cards
    turn.award_spoils(turn.winner)
  end

  def end_game_message
    if @player1.has_lost?
      p "#{@player2.name} has won the game!"
    elsif @player2.has_lost?
      p "#{@player1.name} has won the game!"
    else
      p "---- DRAW ----"
    end
  end
end
````
## Testing with RSpec
- **Purpose:** Ensures that each component works as expected. You have unit tests for each class to confirm correct behavior.

For example, the `deck_spec.rb` test:

- Whether Deck can add and remove cards.
- Whether it correctly calculates the percentage of high-ranking cards

## Closing Summary
In summary, the "War or Peace" game is structured around five key classes, each responsible for different parts of the game logic. The game is launched from the war_or_peace_runner.rb file, where it creates a deck of 52 cards, splits it between two players, and runs the game until a winner is declared. The structure and logic ensure the game follows the classic War card game mechanics, with test coverage to validate its correctness.
