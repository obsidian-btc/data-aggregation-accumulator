module DataAggregation::Accumulator
  class Log < ::Log
    def tag!(tags)
      tags << :data_aggregation
      tags << :verbose
    end
  end
end
