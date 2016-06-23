require './lib/rbtm.rb'
require 'test/unit'

class TestRule < Test::Unit::TestCase
  def test_init
    r = Rbtm::Rule.new('flop', '0', 'flop', '1', 'R')

    assert_equal(r.state, 'flop')
    assert_equal(r.read, '0')
    assert_equal(r.next_state, 'flop')
    assert_equal(r.write, '1')
    assert_equal(r.direction, 'R')
  end

  def test_signature
    r = Rbtm::Rule.new('erase', '0', 'erase', '_', 'R')

    assert_equal(r.signature, ['erase', '0'])
  end

  def test_to_s
    r = Rbtm::Rule.new('back', '1', 'back', '1', 'L')

    assert_equal(r.to_s, 'back 1 back 1 L')
  end
end
