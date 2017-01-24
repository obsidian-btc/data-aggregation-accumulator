module DataAggregation::Accumulator
  module Controls
    module Dispatcher
      def self.example(category=nil, cache: nil)
        cache = true if cache.nil?

        dispatcher = Example.build

        SubstAttr::Substitute.(:cache, dispatcher)
        SubstAttr::Substitute.(:write, dispatcher)

        dispatcher.category = category if category

        Cache.configure dispatcher if cache

        dispatcher
      end

      module Cache
        def self.configure(dispatcher)
          id = ID.example
          output_message = Messages::Output::Preceding.example
          cache_version = Version::Output::Preceding.example

          dispatcher.cache.add id, output_message, cache_version
        end
      end

      class Example
        include DataAggregation::Accumulator::Dispatcher

        projection Controls::Projection::Example
        output_message Controls::Messages::Output::SomeMessage
        category Controls::StreamName::Output::Category.example
      end
    end
  end
end
