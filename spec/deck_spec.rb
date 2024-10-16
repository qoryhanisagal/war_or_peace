# Require the Deck and Card classes
require_relative '../lib/deck'
require_relative '../lib/card'

# Begin describing the Deck class
RSpec.describe Deck do
  context 'when dealing with a new deck' do
    it 'can be created with cards' do
      # Create two card objects
      card1 = Card.new('Ace', :spade, 14)   # Create a card
      card2 = Card.new('King', :heart, 13)  # Create another card
      deck = Deck.new([card1, card2])       # Create a deck with the cards

      # Expect the deck to contain the cards
      expect(deck.cards).to eq([card1, card2])
    end

    it 'can count the number of cards in the deck' do
      card1 = Card.new('Ace', :spade, 14)
      card2 = Card.new('King', :heart, 13)
      deck = Deck.new([card1, card2])

      # Expect the count to return 2 initially
      expect(deck.count).to eq(2)

      # Deal a card and expect the count to return 1
      deck.deal
      expect(deck.count).to eq(1)
    end
  end

  context 'when performing operations on the deck' do
    it 'can shuffle the deck' do
      card1 = Card.new('Ace', :spade, 14)
      card2 = Card.new('King', :heart, 13)
      deck = Deck.new([card1, card2])

      # Call the shuffle method
      deck.shuffle

      # Since the shuffle is random, I can't check the exact order.
      # But the deck should still contain both cards.
      expect(deck.cards).to contain_exactly(card1, card2)
    end

    it 'can deal a card from the deck' do
      card1 = Card.new('Ace', :spade, 14)
      card2 = Card.new('King', :heart, 13)
      deck = Deck.new([card1, card2])

      # Deal a card from the deck
      dealt_card = deck.deal

      # Expect the dealt card to be the last one added (King of Hearts)
      expect(dealt_card).to eq(card2)

      # Expect the deck to now only contain the first card
      expect(deck.cards).to eq([card1])
    end
  end
end
