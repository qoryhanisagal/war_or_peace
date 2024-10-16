# A class to represent the Game of War (or Peace)
class Game
  # The initialize method sets up the two players and a counter for tracking turns.
  # - player1 and player2 are passed as instances of the Player class.
  # - @turn_count keeps track of how many turns have been played.
  def initialize(player1, player2)
    @player1 = player1   # Store the first player object passed from the runner file.
    @player2 = player2   # Store the second player object passed from the runner file.
    @turn_count = 0      # Initialize the turn count to 0. This will increment with each turn played.
  end

  # The start method begins the game, displaying a welcome message and player names.
  # It prompts the user to start the game and runs the main game loop until either
  # one player loses all cards or 1,000,000 turns have been played.
  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."  # Welcome message to the player
    p "The players today are #{@player1.name} and #{@player2.name}."        # Display the player names for clarity
    p "Type 'GO' to start the game!"  # Prompt the user to start the game
    input = gets.chomp  # Capture user input

    # If the user doesn't type 'GO', show an error and exit the game
    if input != 'GO'
      p "Invalid input. Type 'GO' to start the game!"
      return
    end

    # Main game loop continues until one player loses or 1,000,000 turns have passed
    until @player1.has_lost? || @player2.has_lost? || @turn_count == 1_000_000
      play_turn  # Play a turn and then check if the game should end
    end

    # Display the final message once the game is over
    end_game_message
  end

  # The play_turn method handles the gameplay for a single turn.
  # It determines the type of turn (basic, war, or mutually assured destruction),
  # plays the turn, and awards spoils to the winner.
  def play_turn
    @turn_count += 1  # Increment the turn count with each call to play_turn
    turn = Turn.new(@player1, @player2)  # Create a new Turn object to represent this turn
    turn_type = turn.type  # Determine the type of the current turn (basic, war, or mutually assured destruction)
    winner = turn.winner   # Determine the winner of the turn based on the turn type

    # Handle a mutually assured destruction turn, where both players lose cards and no winner is declared.
    if turn_type == :mutually_assured_destruction
      p "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play"  # Display message
      turn.pile_cards  # Both players lose 3 cards each without any winner receiving them

    # Handle a war turn, where 6 cards are at stake, and the player with the higher third card wins.
    elsif turn_type == :war
      p "Turn #{@turn_count}: WAR - #{winner.name} won 6 cards"  # Display that a war occurred and show the winner
      turn.pile_cards  # Collect 3 cards from each player
      turn.award_spoils(winner)  # Award all 6 cards to the winner

    # Handle a basic turn, where 2 cards are at stake, and the player with the higher first card wins.
    else
      p "Turn #{@turn_count}: #{winner.name} won 2 cards"  # Display that a basic turn occurred and show the winner
      turn.pile_cards  # Collect 1 card from each player
      turn.award_spoils(winner)  # Award the 2 cards to the winner
    end
  end

  # The end_game_message method displays the final outcome of the game.
  # - It checks whether player1 or player2 has lost, or if the game ended in a draw after 1,000,000 turns.
  def end_game_message
    # If player1 has lost, player2 is declared the winner.
    if @player1.has_lost?
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"  # Display that player2 won

    # If player2 has lost, player1 is declared the winner.
    elsif @player2.has_lost?
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"  # Display that player1 won

    # If neither player has lost and the turn count reached 1,000,000, the game ends in a draw.
    else
      p "---- DRAW ----"  # The game ends in a draw after 1,000,000 turns
    end
  end
end
