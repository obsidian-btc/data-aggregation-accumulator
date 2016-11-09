module DataAggregation::Accumulator
  module Controls
    module Projection
      class Example
        include DataAggregation::Accumulator::Projection
        include Messages::Input

        apply SomeInputMessage do |input_message|
          output.result = output.previous_result + input_message.number
        end
      end
    end
  end
end
