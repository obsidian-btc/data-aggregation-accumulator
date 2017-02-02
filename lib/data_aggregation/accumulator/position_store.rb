module DataAggregation::Accumulator
  module PositionStore
    def self.included(cls)
      cls.class_exec do
        prepend Configure
        prepend Get
        prepend Put

        include OutputCategory

        include Consumer::PositionStore
        include Messaging::StreamName

        dependency :get_last, EventSource::EventStore::HTTP::Get::Last
      end
    end

    module Configure
      def configure
        EventSource::EventStore::HTTP::Get::Last.configure self
      end
    end

    module Get
      def get
        output_category_stream_name = "$ce-#{output_category}"

        event_data, * = get_last.(output_category_stream_name)

        return nil if event_data.nil?

        event_data.data.fetch :source_global_position
      end
    end

    module Put
      def put(_)
      end
    end

    module OutputCategory
      def self.included(cls)
        cls.singleton_class.class_exec do
          attr_accessor :output_category
        end
      end

      attr_writer :output_category

      def output_category
        @output_category ||= self.class.output_category
      end
    end
  end
end
