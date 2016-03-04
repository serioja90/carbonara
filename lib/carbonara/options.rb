require 'configatron'
require 'carbonara/commands/new_command'
require 'carbonara/commands/generate_command'

Options = configatron

commands = [Carbonara::NewCommand, Carbonara::GenerateCommand]
max_len  = commands.max_by{|c| c.command_name.length }.command_name.length

# parse options and commands
global = OptionParser.new do |opts|
  opts.banner = <<-EOF
#{"USAGE".bright}
    #{"carbonara".bright} #{"[options]".color(:white)} #{"command".underline.bright} #{"[command-options]".color(:white)}
EOF

  opts.separator "\nOPTIONS".bright
  opts.on('-h', '--help', 'Show this help message') do
    puts opts.help
    exit
  end

  opts.separator "\nCOMMANDS".bright
  commands.each do |c|
    opts.separator("    " + c.command_name.ljust(max_len + 4).color(:blue) + c.summary)
  end

  opts.separator "\nNOTE".bright
  opts.separator <<-EOF
    See `#{"carbonara".bright} #{"command".underline.bright} --help` for more details about the specific command.

EOF
end

begin
  global.order!
rescue OptionParser::ParseError => e
  puts e.to_s + "\n\n"
  puts global.help
  exit
end

Options.command = ARGV.shift

if commands.map(&:command_name).include?(Options.command)
  puts "Command: #{Options.command}"
  command = commands.detect{|c| c.command_name == Options.command }.new
  command.order!
else
  message = "\n"
  if Options.command.nil?
    message += "Argument missing: ".color(:red) + "command".bright.underline
  else
    message += "Unknown command: ".color(:red) + Options.command.bright
  end
  puts message + "\n\n"
  puts global.help
  exit
end



Options.lock!