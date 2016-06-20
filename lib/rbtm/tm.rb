module Rbtm
  
  ##
  # A Turing machine.
  class TM
    attr_accessor :tape
    attr_reader :rules, :state
    
    def initialize
      @rules = []
    end
    
    ##
    # Operates on the tape until it can no longer find a rule that applies.
    def operate(start_state = '0')
      reset(start_state)
      array = []
      
      loop do
        rule = find_valid_rule
        
        array << Rbtm::Data.new(rule: rule, state: state, tape: @tape)
        
        break if rule.nil?
        
        @state = @tape.operate(rule, @state)
      end
      
      array
    end
    
    ##
    # Resets the Turing machine and its tape.
    def reset(start_state = '0')
      @state = start_state.to_s
      @tape.reset
    end
    
    def rules=(array)
      @rules = []
      array.each { |r| @rules << r }
    end
    
    private
    
    def find_valid_rule
      @rules.each { |r| return r if @state == r.state && @tape.read == r.read }
      nil
    end
  end
end