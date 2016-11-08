module DataAggregation::Accumulator
  module Controls
    module Projection
      class Example
        include EventStore::EntityProjection
        include Messages::Input

        apply SomeInputMessage do |input_message|
          entity.result = entity.previous_result + input_message.number
        end
      end
    end
  end
end
