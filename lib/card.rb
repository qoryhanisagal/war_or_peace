# A class to represent a single card in a deck
class Card
  # Use `attr_reader` to create getter methods for rank, suit and value
  attr_reader :rank, :suit, :value

  # Initialize method to create a new card object with rank, suit, and value
  def initialize(rank, suit, value)
    # The @ symbol represents instance variables that can be accessed in any method in the class
    @rank = rank     # Numeric rank (e.g., 13 for King, 14 for Ace)
    @suit = suit     # Suit of the card (e.g., :heart, :spade)
    @value = value   # String value for face cards (e.g., "King", "Ace")
  end
end
