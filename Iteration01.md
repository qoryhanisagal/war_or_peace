# Iteration 1 - War or Peace

## Objective 
Create the foundational `Card` and `Deck` classes for the War or Peace game/

## Step by Step Questions & Notes:
# Card Class
### 1. Create the `Card` class, which represents a single playing card.
- The `Card` class has three attributes: `rank`, `suit`, and `value`.
- Used `attr_reader` to create getter methods for these attributes.
- Defined an `initialize` method to assign values to `ran`, `suit`, and `value`
- Added comments in the code to explain each line 😩 I am still learning. 
- Next Step, I need to test the `Card` class to make sure it work by writing a test. I will use the test file that loaded in the repository.

## 2. Test the Card Class
- The test file was laready created.
### Test Failures in Iteration 1

#### Failure 1: 
- Test: `Card can be created with a rank, suit, and value`
- Error: `NoMethodError: undefined method `suit’ for #<Card:0x0000000107d857b8 @rank=“Ace”, @suit=:spade, @value=14>`
- Description: The error occurs because the `suit` method is not accessible. This indicates that the `Card` class does not have a reader method for `suit`.

#### Failure 2:
- Test: `Card has readable attributes`
- Error:`NoMethodError: undefined method `suit’ for #<Card:0x0000000107d817f8 @rank=“Queen”, @suit=:diamond, @value=12>`
- Description: Similar to the first failure, the error happens because the `suit` method is not recognized, meaning the `Card` class does not have a way to access the `suit` attribute.

## 3. Fix the Card Class
- I need to fix the Card Class
- Well that's great I misspelled `suit` I spelled it `suite` 🙄

#### Card Class Implementation and Testing
3. Install Rubocop
- Fixed a typo in the `Card` class (`suite` changed to `suit`).
- Successfully created a `Card` class with `rank`, `suit`, and `value` attributes.
- Wrote RSpec tests for creating a card and verifying its attributes.
- Both tests passed without any errors.

# Deck Class
### 1. Create the Deck Class

- The Deck class has one main attribute: an array of Card objects.
- Added attr_reader :cards to allow access to the deck of cards.
- Implemented the initialize method to accept an array of cards.
- Defined methods like rank_of_card_at to get the rank of a card at a specific index.
- Added methods to shuffle, deal, and count the cards in the deck.


#### Failure 1:
- Test: `Deck when dealing with a new deck can return the rank of the cards`
- Error: `expected: 14
got: :spade
(compared using ==)`
- Description: The test expected the rank of the first card in the deck to be 14, but it returned :spade (the card’s suit) instead. This indicates that the rank_of_card_at method is incorrectly returning the suit instead of the rank.

#### Steps to Fix:
- I will check the rank_of_card_at method in the Deck class to ensure it’s returning the correct rank value from the card object, not the suit.

### 2. Fix the Deck Class
- Fixed the rank_of_card_at method by ensuring that it returns the rank of the card instead of the suit.
- Re-ran the tests, and now the correct rank is returned, resolving the failure.

## Turn Class

