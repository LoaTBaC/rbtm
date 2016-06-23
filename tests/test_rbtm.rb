require './lib/rbtm.rb'
require 'test/unit'

class TestRbtm < Test::Unit::TestCase
  def test_generate
    states = ['st0', 'st1']
    symbols = ['_', '0', '1']

    text = Rbtm.generate(states, symbols)

    assert_equal(text, "st0\t_\nst0\t0\nst0\t1\n\nst1\t_\nst1\t0\nst1\t1\n\n")
  end

  def test_parse_rules
    text = %(
    # this line is a comment
    flop 0 flop 1 R
    flop 1 flop 0 R
    # malformed rule, will not be parsed
    flop 0flop 0 R
    )

    rules, state = Rbtm.parse_rules(text)

    assert_equal(state, 'flop')

    assert_equal(rules.size, 2)

    r0 = rules[['flop', '0']]
    r1 = rules[['flop', '1']]

    assert_equal(r0.state, 'flop')
    assert_equal(r0.read, '0')
    assert_equal(r0.next_state, 'flop')
    assert_equal(r0.write, '1')
    assert_equal(r0.direction, 'R')

    assert_equal(r1.state, 'flop')
    assert_equal(r1.read, '1')
    assert_equal(r1.next_state, 'flop')
    assert_equal(r1.write, '0')
    assert_equal(r1.direction, 'R')
  end

  def test_turing_machine
    r0 = Rbtm::Rule.new('flop', '0', 'flop', '1', 'R')
    r1 = Rbtm::Rule.new('flop', '1', 'flop', '0', 'R')

    rules = {r0.signature => r0, r1.signature => r1}

    t = Rbtm::Tape.new('0010')
    head = Rbtm::Head.new(t, 'flop')

    Rbtm.turing_machine(rules, head)

    assert_equal(t.to_s, '1101')
  end
end
