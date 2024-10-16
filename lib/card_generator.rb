# lib/card_generator.rb

# The CardGenerator class reads card data from a text file and generates an array of Card objects.
class CardGenerator
  attr_reader :cards  # Allows external access to the @cards array, which will hold the generated Card objects

  # Initialize method for the CardGenerator class.
  # It accepts a filename, reads the file, and generates cards.
  def initialize(filename)
    @cards = []  # Initialize an empty array to store the generated Card objects
    generate_cards(filename)  # Call the generate_cards method to read the file and create cards
  end

  # This method reads the given file and creates a Card object for each line in the file.
  # Each line of the file contains the rank, suit, and value of a card separated by commas.
  def generate_cards(filename)
    # Open the file and read it line by line
    File.open(filename).each do |line|
      # Split the line by ', ' to extract the rank, suit, and value components
      card_data = line.chomp.split(', ')
      rank = parse_rank(card_data[0])  # Parse the rank from the string
      suit = card_data[1].downcase.to_sym  # Convert the suit to lowercase and symbol (e.g., :heart)
      value = card_data[2].to_i  # Convert the value to an integer

      # Create a new Card object with the parsed rank, suit, and value, and add it to the @cards array
      @cards << Card.new(rank, suit, value)
    end
  end

  private

  # This method converts the rank string to an integer.
  # For ranks like "2" to "10", it converts them to integers.
  # For face cards and aces, it converts them to their respective values (e.g., Jack = 11, Queen = 12, etc.).
  def parse_rank(rank_string)
    # Use a case statement to match the rank string
    case rank_string
    when '2', '3', '4', '5', '6', '7', '8', '9', '10'
      rank_string.to_i  # Convert string numbers (e.g., '2', '3') to integers
    when 'Jack'
      11  # Return 11 for 'Jack'
    when 'Queen'
      12  # Return 12 for 'Queen'
    when 'King'
      13  # Return 13 for 'King'
    when 'Ace'
      14  # Return 14 for 'Ace'
    else
      0  # If no match is found, return 0 (edge case handling)
    end
  end
end