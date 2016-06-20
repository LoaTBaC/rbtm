module Rbtm
  
  ##
  # A single rule for a Turing machine.
  class Rule
    attr_reader :move, :name, :next_state, :read, :state, :write
    
    ##
    # Initializes the rule from a hash.
    #
    # Hash keys:
    #   :move       => direction to move head ('left', 'none', or 'right')
    #   :name       => name of rule (optional)
    #   :next_state => next state to go to
    #   :read       => current symbol being read from tape
    #   :state      => current state
    #   :write      => symbol to write to tape
    def initialize(hash)
      @move =
      case hash.fetch(:move).to_s[0].downcase
      when 'l'
        :L
      when 'r'
        :R
      else
        :N
      end
      
      @name = hash.fetch(:name, '').to_s
      @next_state = hash.fetch(:next_state).to_s
      @read = hash[:read].to_s.empty? ? ' ' : hash[:read].to_s[0]
      @state = hash.fetch(:state).to_s
      @write = hash[:write].to_s.empty? ? ' ' : hash[:write].to_s[0]
    end
    
    ##
    # Returns a string representation of the rule in the form "name: (state, read, write, move, next_state)".
    def to_s
      "#{name}: (#{state}, #{read}, #{write}, #{move}, #{next_state})"
    end
  end
end