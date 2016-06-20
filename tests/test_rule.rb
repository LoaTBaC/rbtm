require './lib/rbtm.rb'
require 'test/unit'

class TestRule < Test::Unit::TestCase
  def test_rule
    h = {
      move: 'qwkcxvz', name: 'test', next_state: 0, read: '1 million',
      state: '0', write: 0
    }
    rule = Rbtm::Rule.new(h)
    
    assert_equal(rule.move, :N)
    assert_equal(rule.name, 'test')
    assert_equal(rule.next_state, '0')
    assert_equal(rule.read, '1')
    assert_equal(rule.state, '0')
    assert_equal(rule.write, '0')
    assert_equal(rule.to_s, 'test: (0, 1, 0, N, 0)')
  end
end