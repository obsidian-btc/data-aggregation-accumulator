require 'entity_cache'
require 'event_store/consumer'
require 'event_store/consumer/error_handler'
require 'entity_projection'
require 'log'

module DataAggregation
  Accumulator = Module.new
end

require 'data_aggregation/accumulator/log'

require 'data_aggregation/accumulator/accumulator'
require 'data_aggregation/accumulator/dispatcher'
require 'data_aggregation/accumulator/message'
require 'data_aggregation/accumulator/position_store'
require 'data_aggregation/accumulator/projection'
