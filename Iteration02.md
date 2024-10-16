# Iteration 2 - War or Peace

# Objective
In Iteration 2, we I expanded the game's logic by introducing the `Player` and `Turn` classes, which handle the players' decks and the game's turns.

### Key Classes Added:
- **Player Class**: Represents a player in the game.
- **Turn Class**: Handles the logic for each round of the game.

# Player Class

The `Player` class represents each player in the game and manages their deck of cards. The player interacts with the deck by drawing cards, and determining if they have lost the game.

### Player Class Code:
```ruby
class Player
  attr_reader :name, :deck
  
  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    @deck.cards.empty?
  end
end
```

# Player Spec:
I encountered a few errors when testing the Player class. The initial test for checking if the player has lost was returning false because the deck was not empty after removing cards one by one.

### Test Case for Player Class:
```` ruby
RSpec.describe Player do
  before(:each) do
    @card1 = Card.new('King', :heart, 13)
    @card2 = Card.new('7', :spade, 7)
    @card3 = Card.new('Ace', :diamond, 14)
    @deck = Deck.new([@card1, @card2, @card3])
    @player = Player.new('Qoiree', @deck)
  end

  it 'exists and has attributes' do
    expect(@player).to be_an_instance_of(Player)
    expect(@player.name).to eq('Qoiree')
    expect(@player.deck).to eq(@deck)
  end

  it 'can determine if the player has lost' do
    expect(@player.has_lost?).to eq(false)  # Player has not lost at first
    @player.deck.remove_card # Remove King
    @player.deck.remove_card # Remove 7
    @player.deck.remove_card # Remove Ace
    expect(@player.has_lost?).to eq(true)  # Player loses after cards are removed
  end
end
````

# Turn Class
The Turn class introduces the game's logic for each round, determining the type of turn and the winner. There are three types of turns:

 - The players' top cards have different ranks.
 - The players' top cards have the same rank, but their third cards are different.
 - The players' top and third cards have the same rank.

### Turn Class Code:
````ruby
class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) &&
          player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
      :war
    else
      :mutually_assured_destruction
    end
  end

  def winner
    if type == :basic
      player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0) ? player1 : player2
    elsif type == :war
      player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2) ? player1 : player2
    else
      'No Winner'
    end
  end

  def pile_cards
    if type == :basic
      spoils_of_war << player1.deck.remove_card
      spoils_of_war << player2.deck.remove_card
    elsif type == :war
      3.times do
        spoils_of_war << player1.deck.remove_card
        spoils_of_war << player2.deck.remove_card
      end
    else
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    end
  end

  def award_spoils(winner)
    winner.deck.cards.concat(spoils_of_war) unless winner == 'No Winner'
    @spoils_of_war = []
  end
end
````
### Turn Spec
I experienced an error where the test was returning :war instead of :basic. This occurred due to incorrect card ranks being set up in the tests.
### Test Case for Turn Class:
````ruby
RSpec.describe Turn do
  before(:each) do
    @card1 = Card.new('Jack', :heart, 11)
    @card2 = Card.new('10', :heart, 10)
    @card3 = Card.new('9', :heart, 9)
    @card4 = Card.new('Jack', :diamond, 11)
    @deck1 = Deck.new([@card1, @card2, @card3])
    @deck2 = Deck.new([@card4, @card3, @card2])
    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
    @turn = Turn.new(@player1, @player2)
  end

  it 'can return the type of turn as basic' do
    expect(@turn.type).to eq(:basic)  # Corrected after setting the right card ranks
  end
end
````
# Failures & Fixes:
### Failure 1: Player has lost test
- Error: expected true, got false
- Fix: Initially, not all cards were being removed from the deck before checking if the player lost.
### Failure 2: Turn type test returned :war instead of :basic
- Error: expected :basic, got :war
- Fix: The failure was due to incorrect setup of card ranks in the test. After fixing the card ranks, the test passed successfully.
# Passed Tests:
- After fixing the above issues, all tests for the Player and Turn classes passed successfully.