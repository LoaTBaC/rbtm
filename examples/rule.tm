# Example ruleset

# flop 0 and 1 and move right until you reach a blank
flop   0  flop   1  R
flop   1  flop   0  R
flop   _  erase  _  L # reached a blank

# erase everything and move left until you reach a blank
erase  0  erase  _  L
erase  1  erase  _  L
erase  _  done   _  N # reached a blank

# no rules have a CurrentState for 'done'
# the Turing machine is done
