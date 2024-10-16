# Iteration 4 - War or Peace


## This will fail but I will try

# 1. Plan
We need to create a CardGenerator class that reads a text file and generates Card objects based on the content of the file. The runner file (war_or_peace_runner.rb) will then use this CardGenerator to populate the decks for the game instead of hardcoded cards.

The text file will contain rows like:

# 2. Write Tests First (TDD)
Let's write the tests for our CardGenerator class before implementing the class itself.

In the card_generator_spec.rb, we'll write the tests for reading the file and generating cards.

Create a new file called card_generator_spec.rb in the spec/ directory.

spec/card_generator_spec.rb

# 3. Create the CardGenerator Class
Now let's implement the class that will satisfy these tests.


# 4. Add a Sample cards.txt File
You will need a cards.txt file that looks like this (place it in the root directory):

cards.txt

# 5. Modify the Runner File




