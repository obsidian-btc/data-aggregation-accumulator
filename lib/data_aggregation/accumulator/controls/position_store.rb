module DataAggregation::Accumulator
  module Controls
    module PositionStore
      class Example
        include DataAggregation::Accumulator::PositionStore

        category :some_accumulator
      end
    end
  end
end
