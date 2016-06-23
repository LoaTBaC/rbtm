require './lib/rbtm.rb'
require 'test/unit'

class TestHead < Test::Unit::TestCase
  def test_init
    t = Rbtm::Tape.new('0010')
    h = Rbtm::Head.new(t, '0')

    assert_equal(h.tape, t)
    assert_equal(h.state, '0')
    assert_equal(h.position, t.position)
  end

  def test_operate
    r = Rbtm::Rule.new('flop', '1', 'flop', '0', 'R')
    t = Rbtm::Tape.new('10')
    h = Rbtm::Head.new(t, 'flop')

    h.operate(r)

    assert_equal(h.position, 1)
    assert_equal(h.state, 'flop')
    assert_equal(h.tape.to_s, '00')
  end

  def test_signature
    t = Rbtm::Tape.new
    h = Rbtm::Head.new(t, 'done')

    assert_equal(h.signature, ['done', '_'])
  end
end
