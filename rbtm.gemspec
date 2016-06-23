Gem::Specification.new do |s|
  s.name = 'rbtm'
  s.version = '2.0.2'
  s.executables << 'rbtm' << 'rbtm_rule'
  s.date = '2016-06-23'
  s.summary = 'A simple Turing machine for Ruby'
  s.description = 'A simple Turing machine gem for Ruby; type "rbtm" in bash' +
    ' to run, or "rbtm_rule" to generate a rule template.'
  s.author = 'loatbac'
  s.files = [
    'lib/rbtm.rb', 'lib/rbtm/head.rb'
  ]
  s.homepage = 'https://github.com/LoaTBaC/rbtm'
  s.license = 'MIT'
end
