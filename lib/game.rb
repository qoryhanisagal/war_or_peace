# A class to represent the Game of War (or Peace)
class Game
  # The initialize method sets up the two players and the turn counter for the game
  # - player1 and player2 are instances of the Player class, passed into the Game
  # - @turn_count keeps track of how many turns have been played, starting from 0
  def initialize(player1, player2)
    @player1 = player1   # Assign the player1 object passed from the runner file
    @player2 = player2   # Assign the player2 object passed from the runner file
    @turn_count = 0      # Set the turn counter to 0, which will be incremented as the game progresses
  end

  # The start method begins the game, displaying a welcome message and asking the user to start by typing 'GO'
  # It continues running until one player has lost all their cards or the turn count reaches 1,000,000
  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{@player1.name} and #{@player2.name}." # Display player names to the user
    p "Type 'GO' to start the game!" # Prompt the user to start the game
    input = gets.chomp # Take user input to start the game
    if input != 'GO'  # Check if the user typed 'GO', if not, show an error message and return
      p "Invalid input. Type 'GO' to start the game!"
      return
    end

    # The game continues in a loop until one of the players loses or the turn count reaches 1,000,000
    # In each iteration, a new turn is played, and the turn counter is incremented
    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      play_turn  # Play a turn by calling the play_turn method
    end

    # Once the game ends, display the appropriate end message
    end_game_message
  end

  # The play_turn method handles the logic for each individual turn
  # - It creates a new Turn instance for the two players and determines the turn type (basic, war, or mutually assured destruction)
  # - It handles each type of turn accordingly, with different messages and card removals for each case
  def play_turn
    @turn_count += 1  # Increment the turn counter each time this method is called
    turn = Turn.new(@player1, @player2)  # Create a new Turn instance using player1 and player2
    turn_type = turn.type  # Determine the type of the turn (basic, war, or mutually assured destruction)
    winner = turn.winner   # Determine the winner of the turn based on the turn type

    # If the turn is of type :mutually_assured_destruction, both players lose 3 cards and no winner is declared
    if turn_type == :mutually_assured_destruction
      p "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play" # Display the turn type and message
      turn.pile_cards  # Both players' top 3 cards are removed but not added to spoils

    # If the turn is of type :war, 6 cards are at stake, and the player with the higher third card wins
    elsif turn_type == :war
      p "Turn #{@turn_count}: WAR - #{winner.name} won 6 cards" # Display that WAR occurred and show the winner
      turn.pile_cards  # Pile the cards from both players (3 from each)
      turn.award_spoils(winner)  # Award the spoils (all 6 cards) to the winner

    # If the turn is of type :basic, 2 cards are at stake, and the player with the higher first card wins
    else
      p "Turn #{@turn_count}: #{winner.name} won 2 cards"  # Display that a basic turn occurred and show the winner
      turn.pile_cards  # Pile the cards from both players (1 from each)
      turn.award_spoils(winner)  # Award the spoils (2 cards) to the winner
    end
  end

  # The end_game_message method displays the final result of the game
  # - If player1 has lost, player2 is declared the winner, and vice versa
  # - If neither player has lost after 1,000,000 turns, the game ends in a draw
  def end_game_message
    if @player1.has_lost?  # Check if player1 has lost
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*" # If player1 lost, player2 wins
    elsif @player2.has_lost?  # Check if player2 has lost
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*" # If player2 lost, player1 wins
    else
      p "---- DRAW ----"  # If neither player has lost and the game reached 1,000,000 turns, it's a draw
    end
  end
end
