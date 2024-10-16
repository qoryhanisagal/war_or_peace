# Iteration 2 - War or Peace

## Objective 
Create the foundational `Turn` class for the War or Peace game/

## Step by Step Questions & Notes:
## Turn Class

### Test Failures in Iteration 1 `turn.rb and turn_spec.rb`
#### 1. `turn.rb` failures
- Main Issue:

My initialize method is defined outside the Turn class, which is causing the end keyword to be mismatched.

- Correcting the Code:

	1.	Move the initialize method inside the Turn class.
	2.	Make sure proper indentation for readability and correctness.

### Detailed Breakdown of Player Class:

1.	Class Definition:
	- class Player: This defines the Player class, which will be used to represent each player in the game.
2.	attr_reader :name, :deck:
    - The attr_reader automatically creates getter methods for name and deck. This means we can access these attributes later, but we won’t be able to change them directly (which is good for encapsulation).
3.	initialize(name, deck):
	- This is the constructor method that gets called whenever a new instance of the Player class is created. It takes two parameters:
	- name: The player’s name (e.g., “Megan” or “Aurora”).
	- deck: An instance of the Deck class, which holds the player’s cards.
	- We store the player’s name and deck in instance variables @name and @deck.
4.	has_lost? Method:
	- This method determines if the player has lost by checking if their deck is empty.
	- It calls @deck.cards.empty? to check if the deck is empty:
	- If the deck is empty (true), it returns true, indicating the player has lost.
	- If the deck still contains cards (false), it returns false, meaning the player is still in the game
	- This method is crucial for tracking the game’s progress and determining when a player has lost.

