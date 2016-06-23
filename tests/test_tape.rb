require './lib/rbtm.rb'
require 'test/unit'

class TestTape < Test::Unit::TestCase
  def test_init
    t = Rbtm::Tape.new

    assert_equal(t.position, 0)
    assert_equal(t.tape, '_')

    t = Rbtm::Tape.new('0010')

    assert_equal(t.position, 0)
    assert_equal(t.tape, '0010')
  end

  def test_movement
    t = Rbtm::Tape.new('0110')

    t.left

    assert_equal(t.position, 0)
    assert_equal(t.tape, '_0110')

    5.times { t.right }

    assert_equal(t.position, 5)
    assert_equal(t.tape, '_0110_')
  end

  def test_read_write
    t = Rbtm::Tape.new('_0')

    assert_equal(t.read, '_')

    t.write('0')

    assert_equal(t.read, '0')

    t.right
    t.write('1')

    assert_equal(t.read, '1')
    assert_equal(t.tape, '01')
  end

  def test_to_s
    t = Rbtm::Tape.new('__1000_10__0_')

    assert_equal(t.to_s, '1000_10__0')
  end
end
