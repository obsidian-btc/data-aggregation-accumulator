module DataAggregation::Accumulator
  module Message
    include EventStore::Messaging::Message

    attribute :source_stream_version, default: -1

    virtual :advance

    def applied?(version)
      version <= source_stream_version
    end
  end
end
