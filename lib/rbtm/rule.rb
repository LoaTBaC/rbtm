module Rbtm

  ##
  # A rule for the Turing machine.
  class Rule
    attr_reader :state, :read, :next_state, :write, :direction

    def initialize(state, read, next_state, write, direction)
      @state = state
      @read = read
      @next_state = next_state
      @write = write
      @direction = direction
    end

    ##
    # Returns the signature (state and read) of the rule.
    def signature
      [state, read]
    end

    def to_s
      "#{state} #{read} #{next_state} #{write} #{direction}"
    end
  end
end
