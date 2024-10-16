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