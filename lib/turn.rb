# A class to represent a turn in a game
class Turn
  # Automatically create getter methods for player1, player2, and spoils_of_war using attr_reader
  # This allows other parts of the program to access these attributes, but not modify them directly
  attr_reader :player1, :player2, :spoils_of_war

  # Initialize a turn with two players and an empty spoils_of_war array
  # The constructor takes in two Player objects and prepares an empty spoils_of_war array for collecting cards during the turn
  def initialize(player1, player2)
    @player1 = player1              # The first player in the turn (instance of Player)
    @player2 = player2              # The second player in the turn (instance of Player)
    @spoils_of_war = []             # This array will hold cards collected during the turn, awarded to the winner later
  end

  # Determine the type of turn based on the rank of the players' cards
  # The type of turn can be one of three types:
  # - :basic => Players have different ranks for their first card
  # - :war => Players have the same rank for their first card, but different ranks for their third card
  # - :mutually_assured_destruction => Players have the same rank for their first and third cards
  def type
    # Basic turn: Players have different ranks for their first card
    return :basic if basic_turn?

    # War turn: Players have the same rank for their first card but different ranks for their third card
    return :war if war_turn?

    # Mutually Assured Destruction: Both players have the same rank for their first and third cards
    :mutually_assured_destruction
  end

  # Determine the winner of the turn based on the type of turn
  # The winner depends on the turn type:
  # - Basic turn: The player with the higher first card wins
  # - War turn: The player with the higher third card wins
  # - Mutually Assured Destruction: No winner (both players' cards are discarded)
  def winner
    case type
    when :basic
      basic_winner   # In a basic turn, the winner is the player with the higher rank at position 0
    when :war
      war_winner     # In a war turn, the winner is the player with the higher rank at position 2
    else
      'No Winner'    # In mutually assured destruction, no winner is declared
    end
  end

  # Collect cards from both players into the spoils_of_war array based on the type of turn
  # Depending on the turn type, different numbers of cards will be collected:
  # - Basic turn: One card from each player is added to spoils_of_war
  # - War turn: Three cards from each player are added to spoils_of_war
  # - Mutually Assured Destruction: Three cards are removed from each player's deck, but not added to spoils_of_war
  def pile_cards
    case type
    when :basic
      add_basic_cards_to_spoils   # In a basic turn, each player adds their first card to the spoils_of_war
    when :war
      add_war_cards_to_spoils     # In a war turn, each player adds their first three cards to the spoils_of_war
    when :mutually_assured_destruction
      remove_war_cards            # In mutually_assured_destruction, the top three cards are discarded but not added to spoils_of_war
    end
  end

  # Award the collected spoils_of_war to the winner of the turn
  # If there is a winner (not 'No Winner'), the spoils are added to the winner's deck
  # After awarding the spoils, the spoils_of_war array is cleared
  def award_spoils(winner)
    # Only award spoils if there is a winner (not in the case of 'No Winner')
    winner.deck.cards.concat(@spoils_of_war) unless winner == 'No Winner'
    
    # Clear the spoils_of_war array after awarding the spoils to ensure it's ready for the next turn
    @spoils_of_war = []
  end

  private

  # Helper methods to determine the type of turn

  # A basic turn happens when the players have different ranks for the first card
  def basic_turn?
    # Compare the ranks of the first card (position 0) in each player's deck
    player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
  end

  # A war turn happens when the players have the same rank for the first card, but different ranks for the third card
  # This method also ensures that both players have at least 3 cards before comparing the third card (to avoid errors)
  def war_turn?
    player1.deck.cards.length >= 3 && player2.deck.cards.length >= 3 &&
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
    player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
  end

  # Helper methods for determining the winner of the turn

  # In a basic turn, the player with the higher first card wins
  def basic_winner
    # Compare the ranks of the first card (position 0) in each player's deck
    player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0) ? player1 : player2
  end

  # In a war turn, the player with the higher third card wins
  def war_winner
    # Compare the ranks of the third card (position 2) in each player's deck
    player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2) ? player1 : player2
  end

  # Helper methods for collecting spoils based on the type of turn

  # In a basic turn, both players add their first card to the spoils_of_war
  def add_basic_cards_to_spoils
    # Remove the top card from each player's deck and add them to spoils_of_war
    @spoils_of_war << player1.deck.remove_card
    @spoils_of_war << player2.deck.remove_card
  end

  # In a war turn, both players add their first three cards to the spoils_of_war
  def add_war_cards_to_spoils
    # Remove the top three cards from each player's deck and add them to spoils_of_war
    3.times do
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    end
  end

  # In a mutually_assured_destruction turn, both players' top three cards are removed but not added to the spoils_of_war
  def remove_war_cards
    # Remove the top three cards from each player's deck but discard them (they are not added to spoils_of_war)
    3.times do
      player1.deck.remove_card
      player2.deck.remove_card
    end
  end
end