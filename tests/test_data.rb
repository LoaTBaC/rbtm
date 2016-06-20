require './lib/rbtm.rb'
require 'test/unit'

class TestData < Test::Unit::TestCase
  def test_data
    h = {move: 'r', name: 'flop0', next_state: 0, read: 0, state: 0, write: 1}
    rule = Rbtm::Rule.new(h)
    state = '0'
    tape = Rbtm::Tape.new('00010100')
    
    data = Rbtm::Data.new(rule: rule, state: state, tape: tape)
    
    assert_equal(data.rule_name, rule.name)
    assert_equal(data.state, state)
    assert_equal(data.tape_string, tape.tape_string)
    assert_equal(data.tape_head, tape.head)
  end
end