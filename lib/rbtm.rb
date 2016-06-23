module Rbtm

  ##
  # Regexp for matching rules.
  REGEX = /\s*(\w+)\s+(\w)\s+(\w+)\s+(\w)\s+([LNR])/

  ##
  # Parses rules and start state from a file.
  def self.parse(file)
    rules = {}
    state = nil

    File.readlines(file).each do |line|
      next unless line =~ REGEX

      state ||= $1
      rules[[$1, $2]] = [$3, $4, $5]
    end

    [rules, state]
  end

  ##
  # Runs a Turing machine. Yields current head if given a block.
  def self.turing_machine(rules, head)
    loop do
      rule = rules[head.signature]

      yield head if block_given?
      break unless rule

      head.operate(rule)
    end
  end
end

require 'rbtm/head'
