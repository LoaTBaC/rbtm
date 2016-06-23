# rbtm
A simple Turing machine gem for Ruby; type "**rbtm**" in bash to run, or "**rbtm_rule**" to generate a rule template.

## Using the Turing machine
Usage: rbtm  rule_file  tape  [-v]
```
    -v          verbose mode (show animation)
```
The Turing machine requires both a *rule file* and a *tape* to run. The rule file must be in a simple format which will be described below.

##### Typing the tape
You can *type* the tape directly in the command line:

$ rbtm  rule.tm  100010

##### Using a file
You may also read a tape from a *file*:

$ rbtm  rule.tm  tape.txt

##### Saving output
The output can be saved to a file through normal output redirection:

$ rbtm  rule.tm  100010  >  output.txt

This is not recommended to use with verbose mode, due to the formatting.

#### Verbose mode
In verbose mode, you will be shown an animation of the Turing machine. It will display the *tape*, with a small 'v' above to indicate the position of the *read/write head*. Below the tape is the name of the *current state*.

After each step, verbose mode will wait a short time (configurable) before showing the next step. If you load a long tape, verbose mode is able to *scroll* to display past the limited width of your terminal.

## Rule files
The rules are written in a text file, with one rule per line:
```
CurrentState  _  NewState  C  R
```
The Turing machine will run this rule if it is in **CurrentState** and is reading an **underscore** (\_) character. It will change its state to **NewState**, write the character **C**, and move **right**. Any lines that do not follow this format will be ignored as comments:
```
# Example ruleset

flop    0    flop    1    R    # replace 0 with 1 and move right

flop    1    flop    0    R    # replace 1 with 0 and move right

# Because there are no rules for any characters besides 0 and 1,
# the Turing machine will stop if it reads something other than
# a 0 or 1.
```
This ruleset will move right along the tape, swapping 1s and 0s until it reaches something other than a 1 or 0. The Turing machine always starts in the **CurrentState** of the *first* rule in the file. In this case, it will start in the 'flop' state.

The Turing machine's tape will expand as necessary to accommodate the machine. It is assumed that everything outside of the initial input is *blank*. The symbol for a *blank* space is the **underscore** (\_).

The Turing machine can move **L**, **N**, or **R** (left, none, or right, respectively).

This rule format was originally created by the people of [RubyQuiz](http://www.rubyquiz.strd6.com).

#### Rule generation
As you can probably imagine, it can be quite tedious to type all of the rules out into a file. You can use the **rbtm_rule** utility to help create a *rule template*:

$ rbtm_rule  my_new_rule.tm

**rbtm_rule** will prompt you for a list of states and an alphabet of symbols. These will be used to produce a template:
```
States:  right  erase
Alphabet:  01_
```
Note that the alphabet is adjacent. If you did this:
```
Alphabet:  0  1  _
```
It would be interpreted as an alphabet of 0, 1, and _ **plus** spaces.

If you were to run this, it would produce the following file:
```
right    0
right    1
right    _

erase    0
erase    1
erase    _
```
Note that only this is only a *template* for the rule file. Only the first part of the rules is actually present. You will still have to fill in the rest yourself.

#### Examples
There are a number of example rulesets provided in the [examples](examples) folder.
