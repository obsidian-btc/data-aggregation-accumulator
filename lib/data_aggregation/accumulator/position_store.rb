module DataAggregation::Accumulator
  class PositionStore
    include EventStore::Consumer::PositionStore

    dependency :reader, EventStore::Client::HTTP::Reader

    def configure
      EventStore::Client::HTTP::Reader.configure(
        self,
        stream_name,
        direction: :backward,
        slice_size: 1
      )
    end

    def get
      reader.each do |event_data|
        return event_data.position
      end

      :no_stream
    end
  end
end
