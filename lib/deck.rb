# A class to represent a deck of cards
class Deck
  # Create a getter method to access the cards in the deck
  attr_reader :cards

  # Initialize a new deck with an array of cards
  def initialize(cards)
    @cards = cards # Array of Card object passed when creating the deck
  end

  # Method to return the rank of the card at a given index
  # This method takes an index (0 or 2 typically) and returns the rank of the card at that position
  def rank_of_card_at(index)
    if @cards[index] # Check if the card at the index exists
      @cards[index].rank
    else
      0 # Return 0 if no card exists at that index (edge case)
    end
  end

  # Method to return an array of cards with a rank of 11 or higher (face cards and aces)
  def high_ranking_cards
    @cards.select do |card|
      card.rank >= 11 # Select cards where the rank is 11 or higher
    end
  end

  # Method to return the percentage of high-ranking cards in the deck
  def percent_high_ranking
    high_ranking_count = high_ranking_cards.count  # Count high-ranking cards
    total_cards_count = @cards.count               # Count total cards
    # Calculate the percentage of high-ranking cards, round to 2 decimal places
    (high_ranking_count.to_f / total_cards_count * 100).round(2)
  end

  # Method to remove the top card from the deck
  def remove_card
    @cards.shift # Remove and return the first card from the array (top card)
  end

  # Method to add a card to the bottom of the deck
  def add_card(card)
    @cards.push(card) # Add the card to the end (bottom) of the deck
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
