module DataAggregation::Accumulator
  module Controls
    module Accumulator
      class Example
        include DataAggregation::Accumulator

        output_category StreamName::Output::Category.example
        output_message Messages::Output::SomeMessage
        projection Projection::Example
      end
    end
  end
end
