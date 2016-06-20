module Rbtm
  
  ##
  # rule subcommand.
  def self.rule(options)
    intro('RULE: rule generator') do
      file = options[:file]
      num = options[:number].to_i.positive? ? options[:number].to_i : 1
      
      if options[:example]
        rules = [
          {
            name: 'flop0', state: '0', read: '0', write: '1', move: 'right',
            next_state: '0'
          },
          {
            name: 'flop1', state: '0', read: '1', write: '0', move: 'right',
            next_state: '0'
          }
        ]
      else
        rules = generate_rules(num)
      end
      
      json = encode_rules(rules)
      
      write(file, json)
    end
  end
  
  ##
  # tm subcommand.
  def self.tm(options)
    intro('TM: Turing machine') do
      output = options[:output]
      rule = File.read(options[:rule])
      tape = File.read(options[:tape]).strip
      
      done = simulate(rule, tape, options)
      
      if output
        puts
        write(output, done)
      end
    end
  end
  
  ##
  # vr subcommand.
  def self.vr(options)
    intro('VR: validate rules') do
      file = File.read(options[:file])
      
      validate(file)
    end
  end
  
  private
  
  def self.abort(reason = '')
    puts reason unless reason.empty?
    puts
    puts '-' * 80
    exit
  end
  
  def self.animate(arrays, sleep_time)
    system('clear')
    
    arrays.each do |d|
      puts "#{' ' * d.tape_head}v:#{d.state}"
      puts d.tape_string
      puts d.rule_name
      
      sleep(sleep_time)
      
      system('clear')
    end
  end
  
  def self.encode_rules(rules)
    require 'json'
    
    JSON.generate(rules, indent: "\t", object_nl: "\n", array_nl: "\n")
  end
  
  def self.generate_rules(num)
    contents = []
    
    num.times do
      contents << {
        name: '', state: '0', read: '0', write: '0', move: 'none', next_state: '0'
      }
    end
    
    contents
  end
  
  def self.intro(title, &block)
    system('clear')
    puts '-' * 80
    
    print "RBTM v#{Gem.loaded_specs['rbtm'].version} - "
    puts title
    puts '-' * 80
    puts
    
    self.run(block)
    
    abort
  end
  
  def self.load_rules(text)
    require 'json'
    
    json = JSON.parse(text, :symbolize_names => true)
    rules = []
    
    json.each { |r| rules << Rule.new(r) }
    
    rules
  end
  
  def self.run(block)
    block.call
  rescue Errno::ENOENT
    puts 'Invalid file.'
  end
  
  def self.simulate(rule, tape, options)
    rules = validate(rule)
    start_state = options[:start_state]
    sleep_time = options[:sleep_time] || 0.65
    
    tm = TM.new
    tm.rules = rules
    tm.tape = Tape.new(tape)
    puts
    
    array = start_state.nil? ? tm.operate : tm.operate(start_state)
    
    if options[:verbose]
      animate(array, sleep_time)
    end
    
    puts 'INPUT:'
    puts array[0].tape_string
    puts
    
    puts 'OUTPUT:'
    puts array[-1].tape_string
    
    tm.tape.to_s
  end
  
  def self.validate(text)
    puts 'Parsing ruleset...'
    
    rules = load_rules(text)
  rescue => e
    puts e
    abort('Invalid ruleset.')
  else
    rules.each { |r| puts "\t" + r.to_s }
    puts
    puts 'Valid ruleset.'
    
    rules
  end
  
  def self.write(file, contents)
    if File.exists?(file)
      print "#{file} already exists. Do you wish to overwrite it? (y/n) "
      abort unless $stdin.gets.downcase.start_with?('y')
    end
    
    puts 'Writing file.'
    
    File.open(file, 'w') { |f| f.write(contents) }
  end
end

require 'rbtm/data'
require 'rbtm/rule'
require 'rbtm/tape'
require 'rbtm/tm'