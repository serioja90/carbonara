
module Carbonara
  class Command
    @command_name = ""
    @summary      = ""
    @description  = ""

    class << self
      attr_accessor :command_name, :summary, :description
    end
  end
end