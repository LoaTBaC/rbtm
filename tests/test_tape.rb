require './lib/rbtm.rb'
require 'test/unit'

class TestTape < Test::Unit::TestCase
  def test_init
    tape = Rbtm::Tape.new('001100')
    
    assert_equal(tape.head, 0)
    assert_equal(tape.tape_string, '001100')
    assert_equal(tape.to_s, '001100')
    
    tape = Rbtm::Tape.new('  1100')
    
    assert_equal(tape.head, 2)
    assert_equal(tape.tape_string, '  1100')
    assert_equal(tape.to_s, '1100')
  end
  
  def test_movement
    tape = Rbtm::Tape.new('0010')
    
    tape.left
    
    assert_equal(tape.head, 0)
    assert_equal(tape.read, ' ')
    
    tape.write(1)
    
    assert_equal(tape.read, '1')
    assert_equal(tape.to_s, '10010')
    
    5.times { tape.left }
    
    assert_equal(tape.to_s, '10010')
    
    15.times { tape.right }
    
    assert_equal(tape.to_s, '10010')
    assert_equal(tape.read, ' ')
    
    tape.write(5)
    
    assert_equal(tape.read, '5')
    assert_equal(tape.to_s, '10010     5')
    
    tape.reset
    
    assert_equal(tape.read, '1')
    assert_equal(tape.head, 5)
  end
  
  def test_operate
    tape = Rbtm::Tape.new('0010')
    
    r = Rbtm::Rule.new(state: 0, read: 0, write: 1, move: 'r', next_state: 0)
    
    state = tape.operate(r, '0')
    
    assert_equal(tape.tape_string, '1010')
    assert_equal(tape.to_s, '1010')
    assert_equal(tape.head, 1)
    assert_equal(state, '0')
  end
end