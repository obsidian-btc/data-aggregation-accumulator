module DataAggregation::Accumulator
  module Controls
    module Dispatcher
      def self.example(category=nil, cache: nil)
        cache = true if cache.nil?
        category ||= StreamName::Output::Category.example

        projection_class = Controls::Projection::Example
        output_message_class = Controls::Messages::Output::SomeMessage

        dispatcher = DataAggregation::Accumulator::Dispatcher.new(
          projection_class,
          output_message_class,
          category
        )

        if cache
          id = Controls::ID.example
          output_message = Controls::Messages::Output::Preceding.example
          cache_version = Controls::Version::Output::Preceding.example

          dispatcher.cache.add id, output_message, cache_version
        end

        dispatcher
      end
    end
  end
end
