# Require necessary files to run tests
require 'rspec'
require './lib/player'   # Include the Player class
require './lib/deck'     # Include the Deck class
require './lib/card'     # Include the Card class

# Begin describing the Player class and its behavior
RSpec.describe Player do
  # Setup test data before each test
  before(:each) do
    # Create 5 card objects with varying ranks, suits, and values
    @card1 = Card.new(:heart, 'King', 13)    # King of Hearts
    @card2 = Card.new(:spade, '7', 7)        # 7 of Spades
    @card3 = Card.new(:diamond, 'Ace', 14)   # Ace of Diamonds
    @card4 = Card.new(:club, '10', 10)       # 10 of Clubs
    @card5 = Card.new(:heart, '2', 2)        # 2 of Hearts

    # Create a deck with the 5 cards
    @deck = Deck.new([@card1, @card2, @card3, @card4, @card5])

    # Create a player with the name 'Clarisa' and the deck created above
    @player = Player.new('Clarisa', @deck)
  end

  # Test to check if a Player object can be created with a name and deck
  it 'exists and has attributes' do
    expect(@player).to be_an_instance_of(Player)  # Check if the player is an instance of the Player class
    expect(@player.name).to eq('Clarisa')         # Check if the player's name is correctly assigned
    expect(@player.deck).to eq(@deck)             # Check if the player's deck is correctly assigned
  end

  # Test to check if the player has lost (when their deck is empty)
  it 'can determine if the player has lost' do
    expect(@player.has_lost?).to eq(false)  # Player should not have lost initially, because they still have cards

    # Remove all cards from the player's deck, one by one
    @player.deck.remove_card  # Removes King of Hearts
    @player.deck.remove_card  # Removes 7 of Spades
    @player.deck.remove_card  # Removes Ace of Diamonds
    @player.deck.remove_card  # Removes 10 of Clubs
    @player.deck.remove_card  # Removes 2 of Hearts

    # After all cards are removed, check if the player has lost
    expect(@player.has_lost?).to eq(true)   # Now the player should have lost, since their deck is empty
  end
end