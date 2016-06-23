module Rbtm
  ##
  # Regex for matching rules.
  REGEX = /\s*(\w+)\s+(\w)\s+(\w+)\s+(\w)\s+([LNR])/

  ##
  # Generates a string of blank rules from a list of states and symbols.
  def self.generate(states, symbols)
    text = ''

    states.each do |s|
      symbols.each do |c|
        text << "#{s}\t#{c}\n"
      end
      text << "\n"
    end

    text
  end

  ##
  # Returns rules and start state parsed from text.
  def self.parse_rules(text)
    rules = {}
    state = nil

    text.each_line do |line|
      next unless (d = Rbtm::REGEX.match(line))

      rule = Rbtm::Rule.new(*d[1, 5])
      state ||= rule.state
      rules[rule.signature] = rule
    end

    [rules, state]
  end

  ##
  # Runs a Turing machine. Yields current rule (or nil if no rule) and head if
  # a block is given.
  def self.turing_machine(rules, head)
    loop do
      rule = rules[head.signature]

      yield rule, head if block_given?
      break unless rule

      head.operate(rule)
    end
  end
end

require 'rbtm/head'
require 'rbtm/rule'
require 'rbtm/tape'
