module DataAggregation::Accumulator
  module Projection
    def self.included(cls)
      cls.class_exec do
        include EventStore::EntityProjection
      end
    end

    def output
      @output ||= entity.tap &:advance
    end
  end
end