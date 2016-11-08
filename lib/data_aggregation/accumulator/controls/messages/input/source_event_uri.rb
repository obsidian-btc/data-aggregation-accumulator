module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module SourceEventURI
          def self.example(i=nil, random: nil, stream_position: nil)
            i ||= 0

            stream_position ||= StreamPosition.example i
            stream_name = StreamName::Input.example random: random

            EventStore::Messaging::Controls::Message::Metadata.source_event_uri(
              stream_name: stream_name,
              stream_position: stream_position
            )
          end
        end
      end
    end
  end
end