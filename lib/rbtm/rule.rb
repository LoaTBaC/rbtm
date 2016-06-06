class Rbtm
  
  ##
  # Represents a single rule for a Turing machine.
  class Rule
    attr_reader :state, :read, :write, :next_state
    
    ##
    # Initializes the rule.
    def initialize(state, read, write, move, next_state)
      check(state, read, write, move, next_state)
      
      @state = state
      @read = read[0]
      @write = write[0]
      @move = move[0].upcase
      @next_state = next_state
    end
    
    ##
    # Returns an Integer representation of direction.
    def move
      if @move == 'L'
        -1
      elsif @move == 'N'
        0
      elsif @move == 'R'
        1
      end
    end
    
    ##
    # Returns a readable representation of the rule in the form (state, read, write, move, next_state).
    def to_s
      "(#{@state}, #{@read}, #{@write}, #{@move}, #{@next_state})"
    end
    
    private
    
    def check(state, read, write, move, next_state)
      raise 'expected Integer for state' unless state.is_a?(Integer)
      raise 'expected non-negative value for state' if state.negative?
      raise 'expected String for read' unless read.is_a?(String)
      raise 'expected >= 1 character for read' if read.empty?
      raise 'expected String for write' unless write.is_a?(String)
      raise 'expected >-= 1 character for write' if write.empty?
      raise 'expected String for move' unless move.is_a?(String)
      raise 'expected "L", "N", or "R" for move' unless %w(L N R).include?(
        move[0].upcase)
      raise 'expected Integer for next_state' unless next_state.is_a?(Integer)
      raise 'expected non-negative value for next_state' if next_state
        .negative?
    end
  end
end
