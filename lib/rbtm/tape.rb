module Rbtm

  ##
  # A tape for the Turing machine.
  class Tape
    attr_reader :position, :tape

    def initialize(str = '_')
      @tape = (str.empty? ? '_' : str.dup)
      @position = 0
    end

    ##
    # Move the tape left.
    def left
      if position.zero?
        pad
      else
        @position -= 1
      end
    end

    ##
    # Read a character from the tape.
    def read
      tape[position]
    end

    ##
    # Move the tape right.
    def right
      @position += 1
      pad if position == tape.size
    end

    ##
    # Write a character to the tape.
    def write(char)
      tape[position] = char
    end

    def to_s
      tape.sub(/^_+/, '').sub(/_+$/, '')
    end

    private

    def pad
      tape.insert(position, '_')
    end
  end
end
