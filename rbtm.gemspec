Gem::Specification.new do |s|
  s.name = 'rbtm'
  s.version = '1.1.0'
  s.executables << 'rbtm'
  s.date = '2016-06-06'
  s.summary = 'A Turing machine for Ruby'
  s.description = 'A simple Turing macine gem; type "rbtm" in bash to run.'
  s.author = 'loatbac'
  s.files = [
    'lib/rbtm.rb', 'lib/rbtm/rule.rb', 'lib/rbtm/tape.rb', 'lib/rbtm/tm.rb'
  ]
  s.homepage = 'https://github.com/LoaTBaC/rbtm'
  s.license = 'MIT'
end