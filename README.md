# rbtm
A simple Turing machine gem for Ruby; type "rbtm" in bash to run the executable.

## Using the Turing machine
Usage: rbtm <rule_file> <tape> [-v]
```
    -v              verbose mode (show animation)
```
The Turing machine requires both a rule file and a tape. The rule file must be
in a special format which will be described below. For convenience, you can
either give the tape as a string or in the form of a file (note that newlines and other whitespace will be removed from the end):

$ rbtm rule.tm 100010

works just as well as

$ rbtm rule.tm tape.txt

You can also save the output to a file if you wish, through normal output
redirection, like this:

$ rbtm rule.tm 100010 > output.txt

This is not recommended if you use verbose mode, as it won't be formatted
correctly.

#### Verbose mode
In verbose mode, you will be shown an animation of each stage of the Turing machine's operation. It will show the tape, with a small 'v' to indicate the position of the read/write head. Below the tape is the name of the current state.

Verbose mode is also capable if handling very long tapes, in which case it will scroll to show only the part within the 80 character width of most terminals.

After each step of the Turing machine's operation, verbose mode will wait a short time (default: 0.5 seconds) before showing the next step. For very long tapes, it is recommended to set a shorter time.

### Rule format
The rules are written in a plaintext file, with each line having a single rule:
```
CurrentState  _  NewState  C  R
```
The Turing machine will run this rule if it is in **CurrentState** and is reading an **\_** (*underscore*) character, which is treated as a ***blank***. It will change its state to **NewState**, write the character **C**, and move **right**. Any lines that do not follow this format will be ignored. Here is an example:
```
# Example ruleset

# Swap 0 and 1 and move right until you reach a blank.
flop   0  flop   1  R
flop   1  flop   0  R

# No rules have a blank as the character being read.
# If the Turing machine gets to a blank, it will stop because there
# are no more rules for it to follow.
```
This ruleset will move right along the tape, flipping 1s and 0s until it reaches the end of them. The Turing machine always starts in the **CurrentState** of the first rule in the file. In this case, it will start in the 'flop' state.

The Turing machine treats the *blank* (underscore) character in a somewhat special way. Whenever the Turing machine goes beyond the bounds of the tape, it will add on a *blank*. This allows the tape to be practically infinite in size, as all of it is *blank* except the small part that is being simulated.

The Turing machine can move **L**, **N**, or **R** (left, right, or none, respectively).


This rule format was originally created by the people of [RubyQuiz](http://www.rubyquiz.strd6.com).

### Examples
For more example rulesets to use with the Turing machine, see the examples folder. I have also included a very simple script to help generate rule files automatically.
