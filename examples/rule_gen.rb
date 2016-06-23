#!/usr/bin/env ruby
require 'rbtm'

# Small tool to automatically generate rule file templates.
# Enter states and symbols separated by spaces,
# and the filename to write to.

puts 'States:'
states = gets.strip.split

puts 'Symbols:'
symbols = gets.strip.split
symbols.map! { |s| s = s[0,1] }

puts 'File:'
file = gets.strip

File.open(file, 'w') { |f| f.write(Rbtm.generate(states, symbols)) }
