module Rbtm
  
  ##
  # A tape for a Turing machine.
  class Tape
    attr_reader :head
    
    def initialize(string)
      @tape = string.to_s.split(//)
      reset
    end
    
    ##
    # Moves the head left.
    def left
      if @head.zero?
        @tape.unshift(' ')
      else
        @head -= 1
      end
    end
    
    ##
    # Operates on the tape one time with the given rule and state.
    def operate(rule, state)
      if state == rule.state && read == rule.read
        write(rule.write)
        
        case rule.move
        when :L
          left
        when :R
          right
        end
        
        rule.next_state
      end
    end
    
    ##
    # Returns the value being read at the head's position.
    def read
      @tape[@head]
    end
    
    ##
    # Resets the position of the head.
    def reset
      @head = start
    end
    
    ##
    # Moves the head right.
    def right
      @head += 1
      @tape.push(' ') if @head == @tape.size
    end
    
    ##
    # Returns an unstripped string of the tape.
    def tape_string
      @tape.join
    end
    
    def to_s
      tape_string.strip
    end
    
    ##
    # Writes the given value to the head's position.
    def write(value)
      @tape[@head] = value.to_s.empty? ? ' ' : value.to_s[0]
    end
    
    private
    
    def start
      index = 0
      index += 1 until @tape[index] != ' '
      
      @tape[index].nil? ? 0 : index
    end
  end
end