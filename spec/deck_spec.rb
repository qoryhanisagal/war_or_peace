# Require the Deck and Card classes
require_relative '../lib/deck'
require_relative '../lib/card'

# Begin describing the Deck class
RSpec.describe Deck do
  # Use a before block to set up common test data for all tests
  before(:each) do
    # Create three card objects with different ranks and suits
    @card1 = Card.new(:spade, 'Ace', 14)    # Ace of Spades (rank 14)
    @card2 = Card.new(:heart, 'King', 13)   # King of Hearts (rank 13)
    @card3 = Card.new(:diamond, '5', 5)     # 5 of Diamonds (rank 5)

    # Create a deck containing the three card objects
    @deck = Deck.new([@card1, @card2, @card3])
  end

  # Context for testing deck initialization and card manipulation
  context 'when dealing with a new deck' do
    # Test to verify that a deck can be created and contains the correct cards
    it 'can be created with cards' do
      # Expect the deck to contain the three cards in the correct order
      expect(@deck.cards).to eq([@card1, @card2, @card3])
    end

    # Test to check if the deck can return the rank of cards at specific indices
    it 'can return the rank of the cards' do
      # Expect the rank of the first card (index 0) to be 14 (Ace)
      expect(@deck.rank_of_card_at(0)).to eq(14)

      # Expect the rank of the third card (index 2) to be 5 (5 of Diamonds)
      expect(@deck.rank_of_card_at(2)).to eq(5)
    end

    # Test to check if the deck can count the number of cards
    it 'can count the number of cards in the deck' do
      # Expect the total number of cards to be 3 initially
      expect(@deck.count).to eq(3)

      # After dealing (removing) one card, expect the count to be 2
      @deck.deal
      expect(@deck.count).to eq(2)
    end
  end

  # Context for testing deck operations like shuffle and dealing cards
  describe 'when performing deck operations' do
    # Test to verify that the deck can shuffle its cards
    it 'can shuffle the deck' do
      # Call the shuffle method to randomize the order of cards in the deck
      @deck.shuffle

      # Since shuffle is random, we check if the deck still contains the same cards
      # but we do not check for the order.
      # contain_exactly checks that the deck contains the same cards, regardless of their order.
      expect(@deck.cards).to contain_exactly(@card1, @card2, @card3)
    end

    # Test to verify that a card can be dealt (removed) from the deck
    it 'can deal a card from the deck' do
      # Deal (remove) a card from the top of the deck, which should be the last card (5 of Diamonds)
      dealt_card = @deck.deal

      # Expect the dealt card to be the 5 of Diamonds
      expect(dealt_card).to eq(@card3)

      # After dealing, expect the deck to contain the remaining two cards
      expect(@deck.cards).to eq([@card1, @card2])
    end

    # Test to verify the count of cards in the deck after dealing
    it 'can count the number of cards in the deck after dealing' do
      # Deal one card from the top of the deck
      @deck.deal

      # Expect the count to return 2 after one card is dealt
      expect(@deck.count).to eq(2)
    end
  end
end
