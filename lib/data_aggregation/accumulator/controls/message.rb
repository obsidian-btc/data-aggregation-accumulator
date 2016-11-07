module DataAggregation::Accumulator
  module Controls
    module Message
      def self.example
        SomeMessage.new
      end

      class SomeMessage
        include DataAggregation::Accumulator::Message
      end
    end
  end
end
