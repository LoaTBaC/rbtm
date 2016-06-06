##
# Holds everything.
class Rbtm
  
  ##
  # Picks subprogram to run.
  def self.main(args)
    system('clear')
    puts '-' * 80
    puts
    
    if args.empty?
      list
    elsif args[0].downcase == 'help'
      if args.size == 1
        list
      else
        help(args.drop(1))
      end
    elsif args[0].downcase == 'list'
      list
    elsif args[0].downcase == 'rule'
      rule(args.drop(1))
    elsif args[0].downcase == 'tm'
      tm(args.drop(1))
    elsif args[0].downcase == 'vr'
      vr(args.drop(1))
    else
      puts 'Unrecognized command. Try $ rbtm for a list of commands.'
    end
    
    puts
    puts '-' * 80
  end
  
  private
  
  def self.abort(reason = '')
    puts reason
    puts 'Aborting!'
    puts
    puts '-' * 80
    exit
  end
  
  def self.help(args)
    puts 'RBTM v1.1 - HELP: command help'
    puts '-' * 80
    puts
    
    if args[0].downcase == 'help'
      puts 'Usage: rbtm help [command]'
      puts
      puts 'Summary:'
      puts "\tShows help on COMMAND"
      puts
      puts 'Description:'
      puts "\tShows advanced help for COMMAND. If no COMMAND is given, shows" +
        ' a list'
      puts "\tof all commands instead."
    elsif args[0].downcase == 'list'
      puts 'Usage: rbtm list'
      puts
      puts 'Summary:'
      puts "\tLists all commands"
      puts
      puts 'Description:'
      puts "\tLists all commands. Gives a list of arguments and a short" +
        ' description.'
    elsif args[0].downcase == 'rule'
      puts 'Usage: rbtm rule <file> <number>'
      puts
      puts 'Summary:'
      puts "\tGenerates a file containing NUMBER rules"
      puts
      puts 'Description:'
      puts "\tGenerates a file containing NUMBER blank rules in the proper"
      puts "\tformat."
      puts
      puts "\tEach rule has the following compoents:"
      puts
      puts "\t\tstate\t\t: current state (non-negative Integer)"
      puts "\t\tread\t\t: character being read"
      puts "\t\twrite\t\t: character to write"
      puts "\t\tmove\t\t: direction to move next ('L', 'N', or 'R',"
      puts "\t\t\t\t  meaning left, none, or right, respectively)"
      puts "\t\tnext_state\t: next state (non-negative Integer)"
      puts
      puts "\tEach rule is in the following format:"
      puts
      puts "\t["
      puts "\t\t{"
      puts "\t\t\t\"state\": 0,"
      puts "\t\t\t\"read\": \"0\","
      puts "\t\t\t\"write\": \"1\","
      puts "\t\t\t\"move\": \"R\","
      puts "\t\t\t\"next_state\": 0"
      puts "\t\t}"
      puts "\t]"
      puts
      puts "\tA rule file may have multiple rules chained together within" +
        " the square"
      puts "\tbrackets, separated by commas."
    elsif args[0].downcase == 'tm'
      puts 'Usage: rbtm tm <tape> <ruleset> [output]'
      puts
      puts 'Summary:'
      puts "\tRuns a Turing machine with TAPE and RULE, optionally saving to" +
        " OUTPUT"
      puts
      puts 'Description:'
      puts "\tRuns a Turing machine with a text file TAPE and JSON file RULE,"
      puts "\toptionally saving output to OUTPUT."
    elsif args[0].downcase == 'vr'
      puts 'Usage: rbtm vr <file>'
      puts
      puts 'Summary:'
      puts "\tChecks if FILE is a valid ruleset"
      puts
      puts 'Description:'
      puts "\tChecks if a JSON file FILE is a valid ruleset."
    else
      puts 'Unrecogized command. Try $ rbtm for a list of commands.'
    end
  end
  
  def self.list
    puts 'RBTM v1.1 - LIST: list of commands'
    puts '-' * 80
    puts
    
    puts "\trbtm help [command]\t\tshow help on COMMAND"
    puts "\trbtm list\t\t\tthis list"
    puts "\trbtm rule <file> <number>\tgenerate FILE containing NUMBER rules"
    puts "\trbtm tm <tape> <rule> [output]\trun Turing machine with TAPE" +
      ' and RULE,'
    puts "\t\t\t\t\toptionally saving to OUTPUT"
    puts "\trbtm vr <file>\t\t\tcheck if FILE is a valid ruleset"
  end
  
  def self.rule(args)
    require 'json'
    
    puts 'RBTM v1.1 - RULE: rule generator'
    puts '-' * 80
    puts
    
    abort('Wrong number of arguments.') unless args.size >= 2
    
    file = args.shift
    number = args.shift
    
    if File.exists?(file)
      puts "#{file} already exists. Do you wish to overwrite it?"
      abort unless $stdin.gets.downcase.start_with?('y')
      puts
    end
    
    begin
      number = number.to_i
    rescue
      abort('Invalid number.')
    end
    
    puts 'Writing file.'
    
    File.open(file, 'w') do |f|
      contents = []
      
      number.times do
        contents << {state: 0, read: '0', write: '0', move: 'N', next_state: 0}
      end
      
      contents = JSON.generate(contents, :indent => "\t", :object_nl => "\n",
        :array_nl => "\n")
        
      f.write(contents)
    end
  end
  
  def self.tm(args)
    require 'json'
    
    puts 'RBTM v1.1 - TM: Turing machine'
    puts '-' * 80
    puts
    
    abort('Wrong number of arguments.') unless args.size >= 2
    
    tape = args.shift
    rule = args.shift
    output = args.shift
    abort('Tape does not exist.') unless File.exist?(tape)
    abort('Ruleset does not exist.') unless File.exist?(rule)
    
    tp = File.read(tape).chomp
    rl = File.read(rule)
    puts 'Parsing ruleset...'
    
    json = JSON.parse(rl, :symbolize_names => true)
    rules = []
    json.each do |r|
      st = r[:state]
      rd = r[:read]
      wr = r[:write]
      mv = r[:move]
      ns = r[:next_state]
      
      rules << Rbtm::Rule.new(st, rd, wr, mv, ns)
    end
    
    tape = Rbtm::Tape.new(tp).pad(4)
    
    puts
    puts 'INPUT:'
    puts '"' + tape.to_s + '"'
    puts
    
    Rbtm::TM.run(tape, rules)
    
    puts 'OUTPUT:'
    puts '"' + tape.to_s + '"'
    
    unless output.nil?
      if File.exists?(output)
        puts
        puts "#{output} already exists. Do you wish to overwrite it?"
        abort unless $stdin.gets.downcase.start_with?('y')
      end
      
      puts
      puts 'Writing file.'
      
      File.open(output, 'w') { |o| o.write(tape.to_s) }
    end
  end
  
  def self.vr(args)
    require 'json'
    
    puts 'RBTM v1.1 - VR: validate rules'
    puts '-' * 80
    puts
    
    abort('Wrong number of arguments.') unless args.size >= 1
    
    file = args.shift
    abort('File does not exist.') unless File.exist?(file)
    
    f = File.read(file)
    puts 'Parsing ruleset...'
    
    begin
      json = JSON.parse(file, :symbolize_names => true)
      
      json.each do |r|
        state = r[:state]
        read = r[:read]
        write = r[:write]
        move = r[:move]
        next_state = r[:next_state]
        
        puts "\t" + Rbtm::Rule.new(state, read, write, move, next_state).to_s
      end
    rescue
      puts
      puts 'Invalid ruleset.'
    else
      puts
      puts 'Valid ruleset.'
    end
  end
end

require 'rbtm/rule'
require 'rbtm/tape'
require 'rbtm/tm'