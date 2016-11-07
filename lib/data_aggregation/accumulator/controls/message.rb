module DataAggregation::Accumulator
  module Controls
    module Message
      def self.example(i=nil)
        i ||= 0

        message = SomeMessage.new
        message.some_attribute = i
        message
      end

      class SomeMessage
        include DataAggregation::Accumulator::Message

        attribute :some_attribute, Integer
      end
    end
  end
end
