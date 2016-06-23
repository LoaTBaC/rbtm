require './lib/rbtm.rb'
require 'test/unit'

class TestRbtm < Test::Unit::TestCase
  def test_turing_machine
    r0 = ['flop', '1', 'R']
    r1 = ['flop', '0', 'R']

    rules = {['flop', '0'] => r0, ['flop', '1'] => r1}
    head = Rbtm::Head.new('0010', 'flop')

    Rbtm.turing_machine(rules, head)

    assert_equal(head.to_s, '1101')
  end
end
