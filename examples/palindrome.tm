# Report whether a string of 0 and 1 (i.e. a binary
# number) is a palindrome.
# From RubyQuiz
look_first   0  go_end_0     _  R
look_first   1  go_end_1     _  R
look_first   _  write_es     Y  R
go_end_0     0  go_end_0     0  R
go_end_0     1  go_end_0     1  R
go_end_0     _  check_end_0  _  L
go_end_1     0  go_end_1     0  R
go_end_1     1  go_end_1     1  R
go_end_1     _  check_end_1  _  L
check_end_0  0  ok_rewind    _  L
check_end_0  1  fail_rewind  _  L
check_end_0  _  ok_rewind    _  L
check_end_1  0  fail_rewind  _  L
check_end_1  1  ok_rewind    _  L
check_end_1  _  ok_rewind    _  L
ok_rewind    0  ok_rewind    0  L
ok_rewind    1  ok_rewind    1  L
ok_rewind    _  look_first   _  R
fail_rewind  0  fail_rewind  _  L
fail_rewind  1  fail_rewind  _  L
fail_rewind  _  write_o      N  R
write_es     _  write_s      e  R
write_o      _  done         o  R
write_s      _  done         s  R
