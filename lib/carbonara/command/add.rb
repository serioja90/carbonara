
module Carbonara
  class Command::Add < Command
    self.command_name = "add"
    self.summary      = "Add a new component to microservice application"
    self.description  = "..."

self.banner = <<-EOF
USAGE
    carbonara add <component> <name> [options]
EOF

    def initialize(*args)
      super(*args)

      self.order!
    end
  end
end