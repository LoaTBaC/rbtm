module Rbtm

  ##
  # The read/write head of the Turing machine.
  class Head
    attr_reader :index, :state, :tape

    def initialize(str, state)
      @tape = (str.empty? ? '_' : str.dup)
      @state = state
      @index = 0
    end

    ##
    # Operates on the tape using the given rule.
    def operate(rule)
      @state = rule[0]
      write(rule[1])

      case rule[2]
      when 'L'
        left
      when 'R'
        right
      end
    end

    def signature
      [state, read]
    end

    def to_s
      tape.sub(/^_+/, '').sub(/_+$/, '')
    end

    private

    def left
      if index.zero?
        pad
      else
        @index -= 1
      end
    end

    def pad
      tape.insert(index, '_')
    end

    def read
      tape[index]
    end

    def right
      @index += 1
      pad if index == tape.size
    end

    def write(char)
      tape[index] = char
    end
  end
end
