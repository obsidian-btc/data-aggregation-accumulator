module DataAggregation::Accumulator
  module PositionStore
    def self.included(cls)
      cls.class_exec do
        prepend Configure
        prepend Get
        prepend Put

        include EventStore::Consumer::PositionStore
        include EventStore::Messaging::StreamName

        attr_writer :category_name

        dependency :reader, EventStore::Client::HTTP::Reader
      end
    end

    module Configure
      def configure
        EventStore::Client::HTTP::Reader.configure(
          self,
          category_stream_name,
          direction: :backward,
          slice_size: 1
        )
      end
    end

    module Get
      def get
        reader.each do |event_data|
          global_position = event_data.data.fetch :source_global_position

          return global_position
        end

        :no_stream
      end
    end

    module Put
      def put(_)
      end
    end
  end
end
