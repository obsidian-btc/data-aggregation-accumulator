module DataAggregation::Accumulator
  class PositionStore
    include EventStore::Consumer::PositionStore

    dependency :reader, EventStore::Client::HTTP::Reader

    def configure
      Log.configure self

      EventStore::Client::HTTP::Reader.configure(
        self,
        stream_name,
        direction: :backward,
        slice_size: 1
      )
    end

    def get
      reader.each do |event_data|
        logger.info "-> #{event_data.position} (#{stream_name})"
        return event_data.position
      end

      :no_stream
    end

    def put(_)
    end
  end
end
