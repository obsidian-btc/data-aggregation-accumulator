module DataAggregation::Accumulator
  module Controls
    module Dispatcher
      def self.example(output_category=nil, cache: nil, session: nil)
        cache = true if cache.nil?

        output_category ||= Controls::StreamName::Output::Category.example
        output_message_class = Controls::Messages::Output::SomeMessage
        projection_class = Controls::Projection::Example

        dispatcher = DataAggregation::Accumulator::Dispatcher.build(
          output_category,
          output_message_class,
          projection_class,
          session: session
        )

        SubstAttr::Substitute.(:cache, dispatcher)
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
    end
  end
end
