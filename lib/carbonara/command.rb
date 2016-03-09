
module Carbonara
  class Command < OptionParser
    @command_name = ""
    @summary      = ""
    @description  = ""
    @banner       = ""

    class << self
      attr_accessor :command_name, :summary, :description, :banner
    end

    def initialize(*args)
      super(*args)

      self.banner = self.class.banner

      self.separator("\nDESCRIPTION")
      self.separator(self.class.description)

      self.separator("\nOPTIONS")
      self.on_tail('-h', '--help', 'Show this help message') do
        puts self.help
        exit
      end
    end
  end
end