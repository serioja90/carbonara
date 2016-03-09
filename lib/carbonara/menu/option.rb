
module Carbonara
  class Menu
    class Option
      attr_reader :option, :description

      def initialize(option, description: nil, default: false, &callback)
        @option      = option
        @description = description
        @default     = default
        @callback    = callback
      end

      def default=(value)
        @default = !!value
        @option = @default ? @option.upcase : @option.downcase

        true
      end

      def default?
        return @default
      end

      def select!
        @callback.call(self)

        true
      end
    end
  end
end