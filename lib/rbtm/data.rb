module Rbtm
  
  ##
  # A representation of a single operation of a Turing machine.
  class Data
    attr_reader :rule_name, :state, :tape_head, :tape_string
    
    ##
    # Initializes the data from a hash.
    #
    # Hash keys:
    #   :rule   => current rule being used
    #   :state  => current state of Turing machine
    #   :tape   => current tape
    def initialize(hash)
      @rule_name = hash.fetch(:rule).nil? ? nil : hash.fetch(:rule).name
      @state = hash.fetch(:state)
      @tape_head = hash.fetch(:tape).head
      @tape_string = hash.fetch(:tape).tape_string
    end
  end
end