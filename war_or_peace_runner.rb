# Require necessary files from the lib folder (adjusted for relative path)
=begin
require_relative './lib/card'
require_relative './lib/deck'
require_relative './lib/player'
require_relative './lib/turn'
require_relative './lib/game'

# Step 1: Create 52 cards for a standard deck
# Cards are created using ranks (numeric for 2-10 and values for face cards), 
# suits (hearts, diamonds, clubs, spades), and their corresponding face values (Ace, Jack, Queen, King).

ranks = (2..14).to_a # Array representing ranks from 2 to 14 (where 11=Jack, 12=Queen, 13=King, 14=Ace)
suits = [:heart, :diamond, :club, :spade] # Array of suits
values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'] # Array of corresponding values

cards = [] # Initialize an empty array to hold all card objects
# Loop through each suit and rank to create card objects
suits.each do |suit|
  ranks.each_with_index do |rank, index|
    # Create a new card for each combination of rank and suit
    cards << Card.new(rank, suit, values[index])
  end
end

# Step 2: Shuffle the deck of cards randomly for a fair game
shuffled_deck = cards.shuffle

# Print full shuffled deck before splitting for debugging
p "Full shuffled deck: #{shuffled_deck.map(&:rank)}"

# Step 3: Split the shuffled deck into two decks, one for each player
deck1 = Deck.new(shuffled_deck[0..25]) # First 26 cards for player1
deck2 = Deck.new(shuffled_deck[26..51]) # Remaining 26 cards for player2

# Print shuffled deck for debugging
# Here, we are printing the ranks of the cards in each player's deck for validation
p "Player 1 shuffled deck: #{deck1.cards.map(&:rank)}"
p "Player 2 shuffled deck: #{deck2.cards.map(&:rank)}"

# Step 4: Create two Player objects using the decks created above
player1 = Player.new("Qoiree", deck1) # Player1 is named "Qoiree" with deck1
player2 = Player.new("Scarlett", deck2) # Player2 is named "Scarlett" with deck2

# Step 9: Start the game by creating a Game object with player1 and player2
# Call the start method to run the game
game = Game.new(player1, player2)
game.start
=end

# New Card Generator war_or_peace_runner.rb
# Require necessary files from the lib folder
require_relative './lib/card'
require_relative './lib/deck'
require_relative './lib/player'
require_relative './lib/turn'
require_relative './lib/card_generator'
require_relative './lib/game'

# Use CardGenerator to create a full deck from cards.txt.
# This reads the file and generates Card objects for each line in the file.
filename = "cards.txt"  # The text file with card information
cards = CardGenerator.new(filename).cards  # Generate an array of Card objects from the file

# Shuffle the deck of cards.
# Shuffling ensures that the cards are dealt randomly to the players.
shuffled_deck = cards.shuffle

# Print the full shuffled deck for debugging (shows the rank of each card).
# This helps us verify that the deck was shuffled correctly.
p "Full shuffled deck (ranks only): #{shuffled_deck.map(&:rank)}"

# Split the shuffled deck into two halves, one for each player.
# Player 1 gets the first 26 cards, and Player 2 gets the next 26 cards.
deck1 = Deck.new(shuffled_deck[0..25])
deck2 = Deck.new(shuffled_deck[26..51])

# Print each player's shuffled deck for debugging (shows the rank of each card).
# This helps us verify that each player has been dealt a shuffled deck.
p "Player 1 shuffled deck (ranks only): #{deck1.cards.map(&:rank)}"
p "Player 2 shuffled deck (ranks only): #{deck2.cards.map(&:rank)}"

# Create two players with their respective shuffled decks.
# Here, we assign custom names to the players.
player1 = Player.new("Qoiree", deck1)
player2 = Player.new("Scarlett", deck2)

# Define and start the game.
# The Game class manages the overall game flow, including playing turns and determining the winner.
game = Game.new(player1, player2)
game.start
