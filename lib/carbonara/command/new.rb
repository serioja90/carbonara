
module Carbonara
  class Command::New < Command
    self.command_name = "new"
    self.summary      = "Initialize a new microservice application"

self.banner = <<-EOF
USAGE
    #{"carbonara new".bright} #{"name".underline} [options]
EOF

self.description  = <<-EOF
    The `new` command allows you to create a new microservice application
    and to generate all the necessary directories and files.


    Example:

    Supose you want to create a new microservice and call it "my-service". With
    carbonara you could simply run this command:

    #{"carbonara new".bright} #{"my-service".underline}

EOF

    def initialize(*args)
      super(*args)

      self.order!

      Options.app_name = ARGV.shift

      unless Options.name
        puts "\n" + "Argument missing: ".color(:red) + "name".bright.underline + "\n\n"
        puts self.help
        exit
      end

      if Options.app_name =~ /\//
        parts = Options.app_name.strip.split("/")

        Options.app_name = parts.pop

        if parts.first == ""
          # absolute path
          Options.path = parts.join("/")
        else
          # relative path
          Options.path = Options.path + "/" + parts.join("/")
        end
      end
    end
  end
end