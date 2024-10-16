require 'rspec'
require_relative '../lib/card_generator'  # Include the CardGenerator class
require_relative '../lib/card'            # Include the Card class, since we are testing Card objects

# Start describing the CardGenerator class
RSpec.describe CardGenerator do
  # First test to check that the CardGenerator object can be initialized with a file
  describe '#initialize' do
    it 'exists and can read from a file' do
      # Provide the name of the file containing the card data
      filename = 'cards.txt'
      
      # Create a new instance of CardGenerator with the filename
      card_generator = CardGenerator.new(filename)

      # Expect the card_generator to be an instance of the CardGenerator class
      expect(card_generator).to be_a(CardGenerator)
    end
  end

  # Test to check that the cards method generates an array of Card objects from the file
  describe '#cards' do
    it 'generates an array of Card objects from a file' do
      # Provide the name of the file containing the card data
      filename = 'cards.txt'
      
      # Create a new instance of CardGenerator with the filename
      card_generator = CardGenerator.new(filename)
      
      # Generate cards from the file
      cards = card_generator.cards

      # Check if the correct number of cards is generated (expecting 52 cards in a standard deck)
      expect(cards.length).to eq(52)

      # Check if the first card generated from the file is a Card object
      expect(cards.first).to be_a(Card)
      
      # Validate the properties of the first card (assumed to be the '2 of Hearts' in this case)
      expect(cards.first.rank).to eq(2)
      expect(cards.first.suit).to eq(:heart)
      expect(cards.first.value).to eq(2)
    end
  end

  # Additional test case to verify the last card in the deck is an Ace with rank 14
  it 'generates cards from a file and checks for Ace as the last card' do
    # Provide the name of the file containing the card data
    filename = 'cards.txt'
    
    # Create a new instance of CardGenerator with the filename
    card_generator = CardGenerator.new(filename)

    # Ensure cards are generated correctly
    expect(card_generator.cards.length).to eq(52)  # There should be 52 cards generated

    # Check if the first card generated is a Card object
    expect(card_generator.cards.first).to be_a(Card)  # Ensure the first card is a valid Card object

    # Check if the last card in the deck is an Ace with rank 14
    expect(card_generator.cards.last.rank).to eq(14)  # The last card in the deck should be Ace with rank 14
  end
end
