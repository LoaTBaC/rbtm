class Rbtm
  
  ##
  # Methods for simulating a Turing machine.
  module TM
    
    ##
    # Operate on the Tape using the given Rule. Returns the modified tape, the new index, and the new state.
    def self.operate(tape, rule, index, state)
      tape = Rbtm::Tape.new(tape) if tape.is_a?(String)
      check(tape, [rule], state, index)
      
      if state == rule.state && tape[index] == rule.read
        tape[index] = rule.write
      end
      
      return tape, (index + rule.move), rule.next_state
    end
    
    ##
    # Process the Tape using the given array of Rules and the given starting state. If it can no longer find a valid rule for the current state and symbol being read, it will stop and return a modified Tape object. With the optional verbose argument true, it will return an array of Tape objects for each step.
    def self.run(tape, rules, state = 0)
      tape = Rbtm::Tape.new(tape) if tape.is_a?(String)
      check(tape, rules, state)
      
      index = tape.start
      return if index.nil?
      
      loop do
        rule = find_valid_rule(state, tape[index], rules)
        break if rule.nil?
        
        tape, index, state = operate(tape, rule, index, state)
      end
      
      tape
    end
    
    private
    
    def self.find_valid_rule(state, read, rules)
      valid = []
      
      rules.each { |r| valid << r if state = r.state && read == r.read }
      
      return valid[0]
    end
    
    def self.check(tape, rules, state, index = 0)
      raise 'expected Tape for tape' unless tape.is_a?(Rbtm::Tape)
      
      unless (rules.select { |r| !r.is_a?(Rbtm::Rule) }).empty?
        raise 'expected Rule for rules'
      end
      
      raise 'expected Integer for state' unless state.is_a?(Integer)
      raise 'expected non-negative value for state' if state.negative?
      
      raise 'expected Integer for index' unless index.is_a?(Integer)
    end
  end
end