require 'carbonara/menu/option'

module Carbonara
  class Menu
    def initialize(question)
      @question = question
      @options  = {}
      @default  = nil
    end

    def on(option, description: nil, default: false, &callback)
      opt = option.to_s.strip.downcase
      if default
        @options[@default].default = false if @default
        @default = opt
      end

      @options[opt] = Carbonara::Menu::Option.new(opt, description: description, default: default, &callback)

      true
    end

    def run!
      response = nil
      loop do
        print @question + " [#{@options.map{|_,v| v.default? ? v.option.upcase : v.option.downcase }.join}] "
        response = STDIN.gets.chomp.downcase.strip
        if response == "" || @options.keys.include?(response)
          break
        else
          puts "Invalid option: ".color(:red) + response
        end
      end

      return response == "" ? @options[@default] : @options[response]
    end
  end
end