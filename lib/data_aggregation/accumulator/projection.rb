module DataAggregation::Accumulator
  module Projection
    def self.included(cls)
      cls.class_exec do
        include EntityProjection
      end
    end

    def output_message
      @output_message ||= entity.tap &:advance
    end
  end
end
