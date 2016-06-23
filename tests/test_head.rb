require './lib/rbtm.rb'
require 'test/unit'

class TestHead < Test::Unit::TestCase
  def test_init
    h = Rbtm::Head.new('', 'st0')

    assert_equal(h.index, 0)
    assert_equal(h.state, 'st0')
    assert_equal(h.tape, '_')

    h = Rbtm::Head.new('0010', 'st0')

    assert_equal(h.index, 0)
    assert_equal(h.state, 'st0')
    assert_equal(h.tape, '0010')
  end

  def test_operate
    h = Rbtm::Head.new('01', 'st0')
    r = ['st1', '1', 'R']

    h.operate(r)

    assert_equal(h.index, 1)
    assert_equal(h.state, 'st1')
    assert_equal(h.tape, '11')
  end

  def test_signature
    h = Rbtm::Head.new('10_000', 'done')

    assert_equal(h.signature, ['done', '1'])
  end

  def test_to_s
    h = Rbtm::Head.new('__1000_10__0_', 'flop')

    assert_equal(h.to_s, '1000_10__0')
  end
end
