Gem::Specification.new do |s|
  s.name = 'rbtm'
  s.version = '2.0.1'
  s.executables << 'rbtm'
  s.date = '2016-06-22'
  s.summary = 'A simple Turing machine for Ruby'
  s.description = 'A simple Turing machine gem for Ruby; type "rbtm" in bash' +
  ' to run the executable.'
  s.author = 'loatbac'
  s.files = [
    'lib/rbtm.rb', 'lib/rbtm/head.rb', 'lib/rbtm/rule.rb', 'lib/rbtm/tape.rb'
  ]
  s.homepage = 'https://github.com/LoaTBaC/rbtm'
  s.license = 'MIT'
end
