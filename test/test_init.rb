ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

ENV['ENTITY_CACHE_SCOPE'] ||= 'exclusive'

ENV['DISABLE_EVENT_STORE_LEADER_DETECTION'] ||= 'on'

require_relative '../init.rb'

require 'data_aggregation/accumulator/controls'

require 'test_bench/activate'

require 'pp'

include DataAggregation::Accumulator
