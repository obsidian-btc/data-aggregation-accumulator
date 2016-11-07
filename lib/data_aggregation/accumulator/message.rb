module DataAggregation::Accumulator
  module Message
    def self.included(cls)
      cls.class_exec do
        include EventStore::Messaging::Message

        attribute :source_stream_version, default: -1

        virtual :advance
      end
    end

    def applied?(version)
      version <= source_stream_version
    end
  end
end
