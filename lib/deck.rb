# A class to represent a deck of cards
class Deck 
  # Create a getter method to access the cards in the deck
  attr_reader :cards

  # Initialize a new deck with an array of cards
  def initialize (cards)
    @cards = cards # Array of Card object passed when creating the deck
  end

  # Method to shuffle the cards in the deck
  def shuffle 
    @cards.shuffle! # Shuffle the deck of cards
  end
  # Method to deal a card (remove and return the top card from the deck)
  def deal
    @cards.pop # Remove and return the last card in the array (top card)
  end

  # Method to return the number of cards left in the deck
  def count
    @cards.size # Return the number of cards in the deck
  end
 end