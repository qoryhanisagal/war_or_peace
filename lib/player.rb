# A class to represent a player in the War or Peace game
class Player
  # Automatically generate getter methods for the player's name and deck using attr_reader
  # This allows access to the player's name and deck but prevents them from being modified directly
  attr_reader :name, :deck

  # Initialize a player with a name and a deck
  # The name will identify the player, and the deck will represent the player's collection of cards
  def initialize(name, deck)
    @name = name  # The player's name (e.g., 'Qoiree', 'Scarlett', 'Skylour')
    @deck = deck  # The player's deck, which holds the player's cards (an instance of the Deck class)
  end

  # Method to determine if the player has lost the game
  # A player is considered to have lost when they have no cards left in their deck
  def has_lost?
    # Check if the player's deck is empty (i.e., the deck has no cards left)
    # Returns true if the deck is empty, indicating that the player has lost the game
    @deck.cards.empty?
  end
end
