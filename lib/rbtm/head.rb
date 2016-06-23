module Rbtm

  ##
  # The read/write head for the Turing machine.
  class Head
    attr_reader :state, :tape

    def initialize(tape, state)
      @tape = tape
      @state = state
    end

    ##
    # Operates on the tape using the given rule.
    def operate(rule)
      @state = rule.next_state
      write(rule.write)
      move(rule.direction)
    end

    ##
    # Returns the position on the tape.
    def position
      tape.position
    end

    ##
    # Returns the signature (state and read) of the head.
    def signature
      [state, read]
    end

    private

    def left
      tape.left
    end

    def move(direction)
      case direction
      when 'L'
        left
      when 'R'
        right
      end
    end

    def read
      tape.read
    end

    def right
      tape.right
    end

    def write(char)
      tape.write(char)
    end
  end
end
