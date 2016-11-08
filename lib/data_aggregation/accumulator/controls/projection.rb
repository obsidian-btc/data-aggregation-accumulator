module DataAggregation::Accumulator::Controls
  module Projection
    def self.example
      message = Message.example

      Example.new message
    end

    class Example
      include EventStore::EntityProjection
      include InputMessage

      apply SomeInputMessage do |input_message|
        entity.result = entity.previous_result + input_message.number
      end
    end
  end
end
