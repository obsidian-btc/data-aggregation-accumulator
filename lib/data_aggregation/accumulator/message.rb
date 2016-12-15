module DataAggregation::Accumulator
  module Message
    def self.included(cls)
      cls.class_exec do
        include EventStore::Messaging::Message

        attribute :source_stream_version, Integer, default: -1
        attribute :source_global_position, Integer

        virtual :advance
      end
    end

    def applied?(version)
      version <= source_stream_version
    end
  end
end
