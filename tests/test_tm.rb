require './lib/rbtm.rb'
require 'test/unit'

class TestTM < Test::Unit::TestCase
  def test_tm
    tape = Rbtm::Tape.new('001001')
    
    f0 = Rbtm::Rule.new(move: 'r', next_state: 0, read: 0, state: 0, write: 1)
    f1 = Rbtm::Rule.new(move: 'r', next_state: 0, read: 1, state: 0, write: 0)
    
    tm = Rbtm::TM.new
    tm.rules = [f0, f1]
    tm.tape = tape
    
    assert_equal(tm.state, nil)
    
    assert_equal(tm.tape, tape)
    assert_equal(tm.rules[0], f0)
    assert_equal(tm.rules[1], f1)
    
    array = tm.operate
    
    assert_equal(tm.tape.to_s, '110110')
    assert_equal(tm.tape.head, 6)
    
    array.each do |d|
      assert_equal(d.class, Rbtm::Data)
    end
    
    tm.reset
    
    assert_equal(tm.tape.head, 0)
  end
end