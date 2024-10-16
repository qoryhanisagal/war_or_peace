# Require the Turn, Player, Deck, and Card classes for testing
require_relative '../lib/turn'
require_relative '../lib/player'
require_relative '../lib/deck'
require_relative '../lib/card'

# Begin describing the Turn class
RSpec.describe Turn do
  # Test the behavior of a basic turn (two players with different first card ranks)
  it 'can have a basic turn' do
    # Create two card objects with different ranks
    card1 = Card.new('Ace', :spade, 14)   # Ace of Spades (Rank: 14)
    card2 = Card.new('King', :heart, 13)  # King of Hearts (Rank: 13)
    deck1 = Deck.new([card1])             # Player 1 has the Ace of Spades
    deck2 = Deck.new([card2])             # Player 2 has the King of Hearts
    player1 = Player.new('Player 1', deck1)  # Player 1 is initialized with their deck
    player2 = Player.new('Player 2', deck2)  # Player 2 is initialized with their deck
    turn = Turn.new(player1, player2)        # A new turn is initialized with both players

    # Expect this to be a basic turn since the first cards have different ranks
    expect(turn.type).to eq(:basic)
    # Player 1 should win because Ace (14) is higher than King (13)
    expect(turn.winner).to eq(player1)
  end

  # Test the behavior of a war turn
  # Two players with equal first card ranks but different third card ranks
  it 'can have a war turn' do
    # Create cards with equal first ranks but different third ranks
    card1 = Card.new('Ace', :spade, 14)   # First card for Player 1
    card2 = Card.new('Ace', :heart, 14)   # First card for Player 2
    deck1 = Deck.new([card1, card2, card1])  # Player 1 has a deck with repeating cards
    deck2 = Deck.new([card2, card1, card2])  # Player 2 has a deck with repeating cards
    player1 = Player.new('Player 1', deck1)
    player2 = Player.new('Player 2', deck2)
    turn = Turn.new(player1, player2)

    # Expect this to be a war turn since the first cards have the same rank
    expect(turn.type).to eq(:war)
  end

  # Test the behavior of a mutually assured destruction turn
  # two players with equal first and third card ranks
  it 'can have a mutually assured destruction turn' do
    # Create cards with equal first and third ranks
    card1 = Card.new('Ace', :spade, 14)
    card2 = Card.new('Ace', :heart, 14)
    deck1 = Deck.new([card1, card1, card1])  # Player 1 has three of the same card
    deck2 = Deck.new([card2, card2, card2])  # Player 2 has three of the same card
    player1 = Player.new('Player 1', deck1)
    player2 = Player.new('Player 2', deck2)
    turn = Turn.new(player1, player2)

    # Expect this to be a mutually assured destruction turn
    # Expect the first and third cards have the same rank
    expect(turn.type).to eq(:mutually_assured_destruction)
    # No winner in this type of turn
    expect(turn.winner).to eq('No Winner')
  end
end
