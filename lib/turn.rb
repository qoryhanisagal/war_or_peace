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
