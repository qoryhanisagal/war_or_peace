# Require necessary files to run tests
require_relative '../lib/player'   # Include the Player class
require_relative '../lib/deck'     # Include the Deck class
require_relative '../lib/card'     # Include the Card class

# Begin describing the Player class and its behavior
RSpec.describe Player do
  # Setup test data before each test
  before(:each) do
    # Create  card objects with varying ranks, suits, and values
    @card1 = Card.new(:heart, 'King', 13)    # King of Hearts
    @card2 = Card.new(:spade, '7', 7)        # 7 of Spades
    @card3 = Card.new(:diamond, 'Ace', 14)   # Ace of Diamonds
    @card4 = Card.new(:club, '10', 10)       # 10 of Clubs
    @card5 = Card.new(:heart, '2', 2)        # 2 of Hearts
    @card6 = Card.new('Jack', :heart, 11)     # Jack of Hearts
    @card7 = Card.new('10', :heart, 10)       # 10 of Hearts
    @card8 = Card.new('9', :heart, 9)         # 9 of Hearts
    @card9 = Card.new('3', :diamond, 3)       # 3 of Diamonds
    @card10 = Card.new('8', :heart, 8)         # 8 of Hearts
    @card11 = Card.new('Queen', :diamond, 12)  # Queen of Diamonds
    @card12 = Card.new('5', :heart, 5)         # 5 of Hearts
    @card13 = Card.new('2', :diamond, 2)       # 2 of Diamonds

    # Create a deck with the 5 cards
    @deck = Deck.new([@card1, @card2, @card3, @card4, @card5, @card6, @card7, @card8, @card9,
                      @card10, @card11, @card12, @card13])

    # Create a player with the name 'Qoiree' and the deck created above
    @player = Player.new('Qoiree', @deck)
  end

  # Test to check if a Player object can be created with a name and deck
  it 'exists and has attributes' do
    expect(@player).to be_an_instance_of(Player) # Check if the player is an instance of the Player class
    expect(@player.name).to eq('Qoiree') # Check if the player's name is correctly assigned
    expect(@player.deck).to eq(@deck) # Check if the player's deck is correctly assigned
  end

  # Test to check if the player has lost (when their deck is empty)
  it 'can determine if the player has lost' do
    expect(@player.has_lost?).to eq(false) # Player should not have lost initially, because they still have cards

    # Remove all cards from the player's deck, one by one
    13.times { @player.deck.remove_card } # Remove all 13 cards from the deck

    # After all cards are removed, check if the player has lost
    expect(@player.has_lost?).to eq(true) # Now the player should have lost, since their deck is empty
  end
end
