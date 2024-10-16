# Require the Deck and Card classes
require_relative '../lib/deck'
require_relative '..lib/card'

# Begin describing the Deck class
RSpec.describe Deck do
 # Test that a deck can be created with an array of Card objects
  it 'can be created with cards' do
    card1 = Card.new('Ace', :spade, 14) # Create a card
    card2 = Card.new('King', :heart, 13) # Create another card
    deck = Deck.new([card1, card2]) # Create a deck with the cards

    # Expect the deck to contain the cards
    expect(deck.cards).to eq([card1, card2])
  end

# Test that the deck can shuffle the cards
it 'can shuffle the deck' do
  card1 = Card.new('Ace', :spade, 14)
  card2 = Card.new('King', :heart, 13)
  deck = Deck.new([card1, card2])

# Call the shuffle method
    deck.shuffle

# Since the shuffle is random, I can't check excat order, but the deck should still contain both cards
    expect(deck.cards) .to contain_exactly(card1, cards2)
  end

# Test that a card can be dealt from the deck
  it 'can deal a card from the deck' do
    card1 = Card.new('Ace', :spade, 14)
    card2 = Card.new('King', :heart, 13)
    deck = Deck.new([card1, card2])

    # Deal a card from the deck
  dealt_card = deck.deal

    # Expect the dealt card to be the last one added (King of Hearts)
  expect(dealt_card). to eq(card2)  

    # Expect the decl to now only contain the first card
  expect(deck.cards). to eq([card1])
end

    # Test that the deck knows how many cards are left


    # Expect the count to return 2 initially 


    # Deal a card and expect the count to return 1
  end
end
