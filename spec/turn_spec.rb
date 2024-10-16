# Require the necessary files for testing
require 'rspec'
require './lib/turn'    # Include the Turn class
require './lib/player'  # Include the Player class
require './lib/deck'    # Include the Deck class
require './lib/card'    # Include the Card class

# Begin describing the Turn class
RSpec.describe Turn do
  # Setup the test data before each individual test
  # This block runs before every test (each `it` block), so we don't need to duplicate setup logic
  before(:each) do
    # Create several Card objects with varying ranks and suits
    @card1 = Card.new(:heart, 'Jack', 11)     # Jack of Hearts
    @card2 = Card.new(:heart, '10', 10)       # 10 of Hearts
    @card3 = Card.new(:heart, '9', 9)         # 9 of Hearts
    @card4 = Card.new(:diamond, '3', 3)       # 3 of Diamonds
    @card5 = Card.new(:heart, '8', 8)         # 8 of Hearts
    @card6 = Card.new(:diamond, 'Queen', 12)  # Queen of Diamonds
    @card7 = Card.new(:heart, '5', 5)         # 5 of Hearts
    @card8 = Card.new(:diamond, '2', 2)       # 2 of Diamonds

    # Create two decks, one for each player
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])  # Deck for player1 (Qoiree)
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])  # Deck for player2 (Scarlett)

    # Create two players with their respective decks
    @player1 = Player.new('Qoiree', @deck1)
    @player2 = Player.new('Scarlett', @deck2)

    # Create a new turn with the two players
    @turn = Turn.new(@player1, @player2)
  end

  # Test 1: Check if the Turn object can be successfully created
  it 'exists and has attributes' do
    # Check if the Turn object was created correctly and is an instance of the Turn class
    expect(@turn).to be_an_instance_of(Turn)

    # Check if the players are correctly assigned to the Turn
    expect(@turn.player1).to eq(@player1)
    expect(@turn.player2).to eq(@player2)

    # Check if the spoils_of_war array is initialized as empty
    expect(@turn.spoils_of_war).to eq([])
  end

  # Test 2: Check the type of the turn when it is :basic
  it 'can return the type of turn as basic' do
    # Debugging statements to print card ranks before checking the type of turn
    puts "Player 1's first card rank: #{@player1.deck.rank_of_card_at(0)}"
    puts "Player 2's first card rank: #{@player2.deck.rank_of_card_at(0)}"

    # Since player1 and player2 have different ranks for their first card (Jack vs. 9),
    # this should be a :basic turn
    expect(@turn.type).to eq(:basic)
  end

  # Test 3: Check the winner of a :basic turn
  it 'can determine a winner in a basic turn' do
    # In a basic turn, the player with the higher rank at position 0 wins.
    # Since player1 has a Jack (rank 11) and player2 has a 9 (rank 9), player1 should win.
    expect(@turn.winner).to eq(@player1)
  end

  # Test 4: Check that cards are collected into the spoils_of_war during a basic turn
  it 'can pile cards for a basic turn' do
    # When pile_cards is called, the first card from each player should be added to the spoils_of_war
    @turn.pile_cards

    # Check if spoils_of_war now contains the first cards of both players
    expect(@turn.spoils_of_war).to include(@card1, @card3)
  end

  # Test 5: Check that the spoils are awarded to the winner in a basic turn
  it 'can award spoils to the winner in a basic turn' do
    # Determine the winner of the turn
    winner = @turn.winner

    # Call pile_cards to collect cards into spoils_of_war
    @turn.pile_cards

    # Award the spoils to the winner
    @turn.award_spoils(winner)

    # Check if player1's deck now contains the spoils (cards that were in spoils_of_war)
    expect(@player1.deck.cards).to include(@card1, @card2, @card5, @card8, @card3)

    # Check if player2's deck no longer contains the card it contributed to spoils_of_war
    expect(@player2.deck.cards).not_to include(@card3)
  end
end