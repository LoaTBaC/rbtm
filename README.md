# rbtm
A simple Turing machine gem; type "rbtm" in bash to run the executable.

## Commands
Usage: rbtm \[options\] \[subcommand \[options\]\]

See 'rbtm COMMAND --help' for more information on a specific command.

### rule
Generates a rule file FILE in JSON format.

Usage: rule \[options\]
```
	-c, --count **NUM**				number of rules to generate (*default: 1*)
	-f, --file **FILE**				rule file (***REQUIRED***)
	-n, --[no-]name					generates names for each rule
	-x, --[no-]example				generates example bit-inversion ruleset
```

### tm
Simulates a Turing machine using rule file RULE and tape TAPE, optionally with an animation.

Usage: tm \[options\]
```
	-o, --output **FILE**			output file
	-r, --rule **RULE**				rule file (***REQUIRED***)
	-s, --state **STATE**			starting state (*default: '0'*)
	-t, --tape **TAPE**				tape file (***REQUIRED***)
	-v, --[no-]verbose				show animation
	-z, --sleep **TIME**			seconds to sleep between frames of animation (*default: 0.65*)
```

### vr
Checks if a rule file FILE is a valid ruleset.

Usage: vr \[options\]
```
	-f, --file **FILE**				rule file (***REQUIRED***)
```

## How to use the Turing machine


### Rule format
Rules are in JSON format, and each rule looks like this:

```json
{ 
	"name": "flop1", 
	"state": "0", 
	"read": "1", 
 	"write": "0", 
 	"move": "right", 
	"next_state": "0" 
}
```

#### Rule tags
Every rule can have 5-6 tags inside it.

```
"name"										name of rule
"state"										current state of the Turing machine
"read"										current symbol being read by the Turing machine
"write"										symbol to write at current tape position
"move"										direction to move head
"next_state"								next state to go to
```

The only one of these tags that can be omitted is "name". All the rest are required.

##### "name"
This should be a short string describing the current rule. It is optional, but can make it easier to understand your program.

##### "state"
This is a string representing the current state of the Turing machine. The Turing machine will stop operating on the tape once it can no longer find any rules that match its state. Unless otherwise specified, the Turing machine will start in state "0".

##### "read"
This is a string representing the symbol being read by the Turing machine. If no rules match the current symbol, the Turing machine will stop operation. Only the first character of this tag is actually used, so to the Turing machine, "1", "111111", and "1 million" are all identical and equate to the character "1".

##### "write"
This is a character representing the symbol to be written to the current position of the tape. If the rule is being used and the "state" and "read" tags match those of the Turing machine, this will be written.

##### "move"
This specifies the direction to move the head of the tape. Strings starting with "r" or "l" will be interpreted as right and left, respectively. Anything else will be interpreted as not moving. Case does not matter.

##### "next_state"
This represents the next state to go to. Once the rule has been applied, if it matches, the Turing machine will move into this state.

#### Rule files
Multiple rules can be placed in one file. They must be enclosed by square brackets \[ \] and separated by commas. Here is an example two-rule file:

```json
[
	{
		"name": "flop0",
		"state": "0",
		"read": "0",
		"write": "1",
		"move": "right",
		"next_state": "0"
	},
	{
		"name": "flop1",
		"state": "0",
		"read": "1",
		"write": "0",
		"move": "right",
		"next_state": "0"
	}
]
```

This is a simple bit-inversion ruleset which will change "1" to "0" and "0" to "1" until it comes to the end of the tape or a blank spot.

#### Rule notation
While there are many ways to show the contents of the rules for a Turing machine, this is the one I will be using:

```
( state , read , write , move , next_state )
```

This means that the second rule shown in the ruleset above would be written as:

```
( 0 , 1 , 0 , R , 0 )
```

### How the Turing machine works
A Turing machine is an abstract idea for a computer, which, while impractical, is theoretically capable of everything a normal computer can do \(just because it is capable doesn't mean it is efficient or easy to use, however\).

The Turing machine knows only its current state. It is given a collection of rules that it is able to read and follow \(a "program" of sorts\). Each rule, at its simplest, consists of five components: the state, the symbol being read, the symbol to write, the direction to move its head on the tape, and the next state to go to.

The Turing machine uses an infinite-length one-dimensional tape of symbols. You can imagine it as a collection of boxes stretching in either direction, each able to hold a single symbol.

```
...[ ] [1] [0] [1] [1] [1] [0] [ ] [0] [1] [ ] [0] [ ] [ ]...
```

While any symbol could be used in the tape, most Turing machines make use of only 1 and 0, plus a blank. Only a tiny portion of this tape is actually used, the section that is not blank.

The Turing machine also has a "head", which moves along the tape. It is only capable of reading/writing at the position of the head. The Turing machine operates in the following order:

1. Read the symbol at the head's position on the tape.
2. Find the current state.
3. Search list of rules for one that matches both current symbol and current state. Stop processing the tape if no rules are found that match.
4. Write the symbol given by the tape to the head's position on the tape.
5. Move the head according to the direction given in the rule.
6. Change the state to the next state given in the rule.
7. Repeat from step 1.

Here is an example of the Turing machine's operation on a small tape using the bit-inversion ruleset shown above. The v will indicate the position of the head over the tape, and the state will be to the right of it.

```
    v - state: 0
...	1	1	0   ...
```

The Turing machine reads the symbol "1", and consults its list of rules, and sees that it has a rule that applies, the "flop1" rule: \(0, 1, 0, R, 0\). Following this rule, the Turing machine writes a 0 to the head's position, moves the head right one step, and goes into state 0 (the same state). It now looks like this:

```
	    v - state: 0
... 0   1   0   ...
```

It then applies the "flop1" rule again:

```
        v - state: 0
... 0   0   0   ...
```

This time it reads a 0, so it follows the "flop0" rule:

```
              v - state: 0
... 0   0   1   ...
```

It now reads a blank. This particular ruleset has no rules that read a blank, and as there are no more rules to apply, so it stops. It has no way of knowing the contents of the rest of the tape, so if there were anything beyond the blank, they would never be reached without a rule for them. Notice that the bit-inversion rule has lived up to its name; the tape has had each symbol inverted:

```
1   1   0   =>   0   0   1
```

This is a simple example, but many, much more advanced programs can be \(and have been\) made for Turing machines. See the examples folder for some example rulesets.

### Quirks

Turing machines could start from anywhere along the tape, but this one will begin with the head at the first non-blank symbol along the tape. Unless otherwise specified, the Turing machine will begin in state "0".

There *should* be at most one rule for each state and symbol being read, as otherwise the Turing machine would have no way of knowing which one to use. However, though mine will accept overlapping rules, it will only make use of the first one it finds.

It would be horribly wasteful and pointless to bother simulating an "infinite" tape for this simple Turing machine. This one is *practically* infinite, as whenever the head moves beyond the edge of the tape, it will add new blank cells as necessary.

## Example rulesets
For easy usage, I have included some example rulesets to try out. See the example folder for the actual files. These are not original rulesets, and they are by no means the only ones you could use. Many of these came from [here](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/turing-machine/four.html).

### binary_increment
Increments a binary number on the tape by one (the left is the least-significant bit).

### unary_subtraction
Subtracts one unary (base-1) number from another. In unary, the value is equal to the number of 1s, so '111111' means 6 and '11' means 2. There should be two unary numbers separated by a single blank cell.

### 3_busy_beaver
A 3 state "busy beaver" program. See the [wikipedia page](https://en.m.wikipedia.org/wiki/Busy_beaver) for more information.

### 4_busy_beaver
A 4 state "busy beaver" program. See the [wikipedia page](https://en.m.wikipedia.org/wiki/Busy_beaver) for more information.

### palindrome
Analyzes the tape to see if it is a palindrome. If it is, it writes a 1; otherwise, it writes a 0.

### bit_invert
You've already seen this one. It just replaces 0 with 1 and 1 with 0 until it runs into a blank.

## Using rbtm from the command line
Here is some information for using the command-line tools provided with rbtm.

### rule
This is a simple automatic rule generator. You can produce a single-rule rule file by doing this:
```
$ rbtm rule -f my\_rule\_file.json
```

You can add the -c option to specify the number of rules. This would produce 3 rules:
```
$ rbtm rule -f my\_rule\_file.json -c 3
```

If you want to generate the "name" parameter for each rule, add the -n option:
```
$ rbtm rule -f my\_rule\_file.json -n
```

It is easy to generate an example bit-inverting ruleset. Note that the -c option doesn't have any effect with this.
```
$ rbtm rule -f my\_example\_rule\_file.json -x
```

### tm
This is the main attraction. It requires a bit more preparation to use, however.

First, you will need to have a rule file ready. I would recommend using the *rule* utility to generate one. A pre-created one can be made by adding the -x option. Alternatively, you could use one of the rulesets in the example folder.

Next, you will need a tape file. This is just a text file with (or without) some symbols. Most rulesets make use of only 1, 0, and space. Try typing a bunch of 1s and 0s, like this "111010001010". Save this to a text file.

Now you can run the Turing machine:

$ rbtm tm -r my\_rule\_file.json -t my\_tape\_file.txt

This will show only the input and output. If you'd rather have a nice view, add the -v option to show an animation:

$ rbtm tm -r my\_rule\_file.json -t my\_tape\_file.txt -v

If you want to speed up or slow down the animation, you can change the time between frames with the -z option. Specify the time in seconds (default is 0.65). This is useful for speeding up the animation if there are a lot of steps. This would be *really* fast:

$ rbtm tm -r my\_rule\_file.json -t my\_tape\_file.txt -v -z 0.01

You can also save the final tape to an output file, like this:

$ rbtm tm -r my\_rule\_file.json -t my\_tape\_file.txt -o output.txt

### vr
This is just a simple utility to check if rbtm can load a rule file you've made. Run it like this:

$ rbtm vr -f my\_rule\_file.json