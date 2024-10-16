# A class to represent a single card in a deck
class Card
  # Use `attr_reader` to create getter methods for rank, suit and value
  attr_reader :rank, :suit, :value

  # Initialize method to create a new card object with rank, suit, and value
  def initialize(rank, suit, value)
    # The @ symbol represents instance variables that can be accessed in any method in the class
    @rank = rank     # The rank of the card (i.e., 'Jack', 'Queen', 'Ace')
    @suit = suit     # The suit of the card (i.e., :heart, :spade, : diamond)
    @value = value   # The value of the card (i.e, 11 for Jack 14 for Ace)
  end
end
