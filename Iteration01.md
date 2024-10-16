# Iteration 1 - War or Peace

## Objective 
Create the foundational `Card` and `Deck` classes for the War or Peace game/

## Step by Step Questions & Notes:
1. Create the `Card` class, which represents a single playing card.
    - The `Card` class has three attributes: `rank`, `suit`, and `value`.
    - Used `attr_reader` to create getter methods for these attributes.
    - Defined an `initialize` method to assign values to `ran`, `suit`, and `value`
    - Added comments in the code to explain each line 😩 I am still learning. 
    - Next Step, I need to test the `Card` class to make sure it work by writing a test. I will use the test file that loaded in the repository.

2. Test the Card Class
    - The test file was laready created.
## Test Failures in Iteration 1

### Failure 1: 
- Test: `Card can be created with a rank, suit, and value`
- Error: `NoMethodError: undefined method `suit’ for #<Card:0x0000000107d857b8 @rank=“Ace”, @suit=:spade, @value=14>`
- Description: The error occurs because the `suit` method is not accessible. This indicates that the `Card` class does not have a reader method for `suit`.

### Failure 2:
- Test: `Card has readable attributes`
- Error:`NoMethodError: undefined method `suit’ for #<Card:0x0000000107d817f8 @rank=“Queen”, @suit=:diamond, @value=12>`
- Description: Similar to the first failure, the error happens because the `suit` method is not recognized, meaning the `Card` class does not have a way to access the `suit` attribute.

3. I need to fix the Card Class
    - Well that's great I misspelled `suit` I spelled it `suite` 🙄

## Card Cass Implementation and Testing
    -Fixed a typo in the `Card` class (`suite` changed to `suit`).
    - Successfully created a `Card` class with `rank`, `suit`, and `value` attributes.
    - Wrote RSpec tests for creating a card and verifying its attributes.
    - Both tests passed without any errors.