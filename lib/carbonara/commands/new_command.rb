
module Carbonara
  class NewCommand < Command
    self.command_name = "new"
    self.summary      = "Initialize a new microservice application"

self.description  = <<-EOF
    The `new` command allows you to create a new microservice application
    and to generate all the necessary directories and files.


    Example:

    Supose you want to create a new microservice and call it "my-service". With
    carbonara you could simply run this command:

    carbonara new my-service

EOF

    def initialize
      @options = OptionParser.new do |opts|
        opts.banner = "Usage:\n    carbonara new <service-name> [options]"

        opts.separator("\nOptions:")
        opts.on('-h', '--help', 'Show this help message') do
          puts opts.help
          exit
        end

        opts.separator("\nDescription:")
        opts.separator(self.class.description)

      end
    end

    def method_missing(name, *args, &block)
      @options.send(name, *args, &block)
    end
  end
end