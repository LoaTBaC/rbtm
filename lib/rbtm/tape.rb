class Rbtm
  
  ##
  # Represents a tape for a Turing machine.
  class Tape
    
    ##
    # Initializes the tape.
    def initialize(string)
      raise 'expected String for string' unless string.is_a?(String)
      
      @contents = string
    end
    
    ##
    # Returns the character at the given index.
    def [](index)
      @contents[index.to_i]
    end
    
    ##
    # Replaces the character at the index with the given character.
    def []=(index, character)
      raise 'expected String for character' unless character.is_a?(String)
      
      @contents[index.to_i] = character[0]
    end
    
    ##
    # Pads the tape with empty space.
    def pad(amount)
      @contents = (' ' * amount) + @contents + (' ' * amount)
    end
    
    ##
    # Returns the first non-blank index of the tape.
    def start
      index = 0
      
      index += 1 until @contents[index] != ' '
      
      return nil if @contents[index] == nil
      index
    end
    
    ##
    # Returns the contents of the tape.
    def to_s
      @contents
    end
  end
end