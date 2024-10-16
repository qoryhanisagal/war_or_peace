# A class to represent a turn in a game
class Turn
  # Use attr_reader to automatically create getter methods for player1, player2, and spoils_of_war
  attr_reader :player1, :player2, :spoils_of_war
end

# Initialize a turn with two players and an empty spoils_of_war array
def initialize(player1, player2)
  @player1 = player1              # The first player in the turn
  @player2 = player2              # The second player in the turn
  @spoils_of_war = []             # Cards that the winner will collect during this turn
end

  # Determine the type of turn based on the rank of the players' cards
  # There are three types of turns: basic, war, and mutually_assured_destruction
  def type
    # Basic turn: Players have different ranks for the first card
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    # War turn: Players have the same rank for the first card but different ranks for the third card
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
          player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
      :war
    # Mutually Assured Destruction: Players have the same rank for the first and third cards
    else
      :mutually_assured_destruction
    end
  end

  # Determine the winner of the turn based on the type of turn
  # In a basic turn, the player with the higher first card wins
  # In a war turn, the player with the higher third card wins
  # There is no winner in a mutually_assured_destruction turn
  def winner
    case type
    when :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1  # Player 1 wins if their first card has a higher rank
      else
        player2  # Player 2 wins if their first card has a higher rank
      end
    when :war
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1  # Player 1 wins if their third card has a higher rank
      else
        player2  # Player 2 wins if their third card has a higher rank
      end
    else
      'No Winner'  # In mutually assured destruction, there's no winner
    end
  end

    # Collect the cards from both players into the spoils_of_war array based on the type of turn
    def pile_cards
      case type
      when :basic
        # In a basic turn, both players add their first card to the spoils of war
        @spoils_of_war << player1.deck.remove_card
        @spoils_of_war << player2.deck.remove_card
      when :war
      # In a war turn, both players add their first three cards to the spoils of war
      3.times do
        @spoils_of_war << player1.deck.remove_card
        @spoils_of_war << player2.deck.remove_card
      end
    when :mutually_assured_destruction
      # In a mutually assured destruction turn, the first three cards are removed from both players' decks
      # These cards are discarded and not added to the spoils
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    end
  end