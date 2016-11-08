module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module Other
          module EventData
            def self.example(i=nil, source_event_uri: nil)
              source_event_uri ||= SourceEventURI.example i

              message = SomeInputMessage.new
              message.metadata.source_event_uri = source_event_uri
              message
            end

            def self.example
              type = Type.example

              EventStore::Client::HTTP::Controls::EventData::Read.example(
                type: type,
                data: {},
                metadata: false
              )
            end

            module StreamPosition
              def self.example(i=nil)
                i ||= 0

                i * 2
              end
            end

            module SourceEventURI
              def self.example(i=nil)
                stream_position = StreamPosition.example i

                Input::SourceEventURI.example stream_position: stream_position
              end
            end

            module Type
              def self.example
                OtherInputMessage.message_type
              end
            end
          end

          class OtherInputMessage
            include EventStore::Messaging::Message
          end
        end
      end
    end
  end
end
