module DataAggregation::Accumulator
  module Controls
    module Projection
      class Example
        include DataAggregation::Accumulator::Projection
        include Messages::Input

        apply SomeInputMessage do |input_message|
          output_message.result = output_message.previous_result + input_message.number
        end
      end
    end
  end
end
