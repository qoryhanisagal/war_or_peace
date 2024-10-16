# Require the Card class
# I am using `require_relative` to specify the relative path to the Card class definition.
# This ensures the correct file is loaded without dependency on the full file system path.
require_relative '../lib/card'

# Begin describing the Card class for testing purposes
# RSpec is used here to create a suite of tests for the Card class.
RSpec.describe Card do
  # Test to check if a Card object can be successfully created with specific attributes.
  it 'can be created with a rank, suit, and value' do
    # Create a new Card object with specific attributes: rank, suit, and value.
    # Here I am setting rank to 14 (Ace), suit to :spade, and value to 'Ace' (the card's name).
    card = Card.new(14, :spade, 'Ace')

    # Expect the card to have the correct rank (numeric), which is 14 for Ace.
    # This verifies that the rank attribute is correctly set when the Card object is created.
    expect(card.rank).to eq(14)

    # Expect the card to have the correct suit, which in this case is :spade.
    # This ensures that the suit attribute is correctly assigned.
    expect(card.suit).to eq(:spade)

    # Expect the card to have the correct value (a string), which represents the face value of the card, in this case 'Ace'.
    # This is important for cards that have special names, like face cards (Jack, Queen, King, Ace).
    expect(card.value).to eq('Ace')
  end

  # The first test failed previously, so I added a second test to check if the Card class has readable attributes.
  # This means I am testing whether I can correctly retrieve the attributes of a Card object after it has been created.
  it 'has readable attributes' do
    # Create another Card object, this time with rank 12 (Queen), suit :diamond, and value 'Queen'.
    # This tests whether I can correctly retrieve these attributes for other cards, such as face cards like the Queen.
    card = Card.new(12, :diamond, 'Queen')

    # Expect the card to have the correct suit. Here we check that the suit is set to :diamond.
    expect(card.suit).to eq(:diamond)

    # Expect the card to have the correct rank (numeric), which is 12 for Queen.
    expect(card.rank).to eq(12)

    # Expect the card to have the correct value, which is 'Queen'.
    # This verifies that the card's value is correctly stored as a string.
    expect(card.value).to eq('Queen')
  end
end
