
module Carbonara
  class MainParser
    def initialize
      @options = OptionParser.new do |opts|
        opts.banner = "Usage:\n    carbonara [options] <command> [command-options]"

        opts.separator("\nOptions:")
        opts.on('-h', '--help', 'Show this help message') do
          puts opts.help
          exit
        end

        opts.separator ""
        opts.separator IO.read("files/commands.txt")
      end
    end

    def parse!
      @options.parse!
    end

    def method_missing(name, *args, &block)
      @options.send(name, *args, &block)
    end
  end
end