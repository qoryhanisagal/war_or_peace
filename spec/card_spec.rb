# Require the Card class
# I prefer `require_relative` as require `rspec` caused too many errors.
# Test to check if a card can be successfully created
require_relative '../lib/card'

# Begin describing the Card class
RSpec.describe Card do
  # Test to check if a card can be successfully created
  it 'can be created with a rank, suit and value' do
    # Create a new Card object
    card = Card.new('Ace', :spade, 14)

    # Expect the card to have a rank of 'Ace'
    expect(card.rank).to eq('Ace')
    # Expect the card to have a suit of :spade
    expect(card.suit).to eq(:spade)
    # Expect the card to have a value of 14
    expect(card.value).to eq(14)
  end

  # The first test failed, so we added this test to check if the card has readable attributes
  it 'has readable attributes' do
    # Create a new Card object with rank 'Queen', suit diamond, and value 12
    card = Card.new('Queen', :diamond, 12)

    # Expect the card to have a suit of :diamond
    expect(card.suit).to eq(:diamond)
    # Expect the card to have a rank of 'Queen'
    expect(card.rank).to eq('Queen')
    # Expect the card to have a value of 12
    expect(card.value).to eq(12)
  end
end
