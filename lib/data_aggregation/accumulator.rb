require 'entity_cache'
require 'event_store/consumer'
require 'event_store/entity_projection'

module DataAggregation
  Accumulator = Module.new
end

require 'data_aggregation/accumulator/dispatcher'
require 'data_aggregation/accumulator/message'
require 'data_aggregation/accumulator/position_store'
