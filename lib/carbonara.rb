require "optparse"
require "rainbow"
require "rainbow/ext/string"
require "carbonara/version"
require "carbonara/options"
require "carbonara/menu"

module Carbonara
  class Application
    def initialize
      @command = Options.command
    end


    def run!
      # execute the tasks requested by user
      case @command
      when 'new'
        require 'carbonara/tasks/new'

        Rake::Task['new'].invoke
      end
    end
  end
end
