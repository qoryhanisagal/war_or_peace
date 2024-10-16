class Game
  # The initialize method accepts two player objects (already created outside this class)
  def initialize(player1, player2)
    @player1 = player1  # Player 1 is passed in with their deck and name (e.g., Qoiree)
    @player2 = player2  # Player 2 is passed in with their deck and name (e.g., Scarlett)
    @turn_count = 0     # Set the turn counter to 0
  end

  # Method to start the game
  def start
    # Display a welcome message with the player names
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are #{@player1.name} and #{@player2.name}."
    p "Type 'GO' to start the game!"

    # Capture user input and check if it's "GO"
    input = gets.chomp
    if input != 'GO'
      p "Invalid input. Type 'GO' to start the game!"
      return
    end

    # Main game loop: Continue playing until a player has lost or 1,000,000 turns are reached
    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      play_turn
    end

    # Display the final game message
    end_game_message
  end

  # Method to handle a single turn
  def play_turn
    @turn_count += 1  # Increment the turn count
    turn = Turn.new(@player1, @player2)  # Create a new Turn object with both players
    turn_type = turn.type  # Determine the type of the turn
    winner = turn.winner   # Determine the winner of the turn

    # Handle the different types of turns and display appropriate messages
    if turn_type == :mutually_assured_destruction
      p "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play"
      turn.pile_cards  # No spoils awarded in mutually assured destruction
    elsif turn_type == :war
      p "Turn #{@turn_count}: WAR - #{winner.name} won 6 cards"
      turn.pile_cards
      turn.award_spoils(winner)
    else
      p "Turn #{@turn_count}: #{winner.name} won 2 cards"
      turn.pile_cards
      turn.award_spoils(winner)
    end
  end

  # Method to display the final message when the game ends
  def end_game_message
    if @player1.has_lost?
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"  # Player 2 wins
    elsif @player2.has_lost?
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"  # Player 1 wins
    else
      p "---- DRAW ----"  # The game ends in a draw after 1,000,000 turns
    end
  end
end
