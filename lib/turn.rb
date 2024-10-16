# A class to represent a turn in a game
class Turn
  # Use attr_reader to automatically create getter methods for player1, player2, and spoils_of_war
  attr_reader :player1, :player2, :spoils_of_war

  # Initialize a turn with two players and an empty spoils_of_war array
  # This constructor sets up the players for the turn and prepares the spoils_of_war to collect cards during the turn
  def initialize(player1, player2)
    @player1 = player1              # The first player in the turn
    @player2 = player2              # The second player in the turn
    @spoils_of_war = []             # Cards that the winner will collect during this turn
  end

  # Determine the type of turn based on the rank of the players' cards
  # The possible turn types are :basic, :war, or :mutually_assured_destruction
  def type
    # If the players have different ranks for the first card, it's a basic turn
    return :basic if basic_turn?
    # If the players have the same rank for the first card but different ranks for the third card, it's a war turn
    return :war if war_turn?

    # If both the first and third cards have the same rank, it's a mutually assured destruction turn
    :mutually_assured_destruction
  end

  # Determine the winner of the turn based on the type of turn
  # The winner is determined by comparing card ranks, or if it's mutually_assured_destruction, there is no winner
  def winner
    # In a basic turn, the player with the higher first card wins
    return basic_winner if type == :basic
    # In a war turn, the player with the higher third card wins
    return war_winner if type == :war

    'No Winner' # There is no winner in a mutually_assured_destruction turn
  end

  # Collect the cards from both players into the spoils_of_war array based on the type of turn
  # Depending on the type of turn, different numbers of cards are collected from each player
  def pile_cards
    case type
    when :basic
      add_basic_cards_to_spoils   # In a basic turn, each player adds their first card to the spoils_of_war
    when :war
      add_war_cards_to_spoils     # In a war turn, each player adds their first three cards to the spoils_of_war
    when :mutually_assured_destruction
      remove_war_cards            # In a mutually_assured_destruction turn, both players' top three cards are discarded
    end
  end

  # Award the collected spoils_of_war to the winner of the turn
  # The winner collects the spoils (the cards that were collected during the turn)
  # If there is no winner (mutually_assured_destruction), the spoils_of_war is simply cleared
  def award_spoils(winner)
    # If there is a winner, the spoils are added to the winner's deck
    winner.deck.cards.concat(@spoils_of_war) unless winner == 'No Winner'
    @spoils_of_war = [] # Clear the spoils_of_war array after awarding the spoils
  end

  private

  # Helper methods for determining the type of turn

  # A basic turn happens when the players have different ranks for the first card
  def basic_turn?
    player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
  end

  # A war turn happens when the players have the same rank for the first card, but different ranks for the third card
  def war_turn?
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
      player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
  end

  # Helper methods for determining the winner of the turn

  # In a basic turn, the player with the higher first card wins
  def basic_winner
    player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0) ? player1 : player2
  end

  # In a war turn, the player with the higher third card wins
  def war_winner
    player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2) ? player1 : player2
  end

  # Helper methods for collecting spoils based on the type of turn

  # In a basic turn, both players add their first card to the spoils_of_war
  def add_basic_cards_to_spoils
    @spoils_of_war << player1.deck.remove_card
    @spoils_of_war << player2.deck.remove_card
  end

  # In a war turn, both players add their first three cards to the spoils_of_war
  def add_war_cards_to_spoils
    3.times do
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    end
  end

  # In a mutually_assured_destruction turn, both players' top three cards are removed but not added to the spoils
  def remove_war_cards
    3.times do
      player1.deck.remove_card
      player2.deck.remove_card
    end
  end
end
