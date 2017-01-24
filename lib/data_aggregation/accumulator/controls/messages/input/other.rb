module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module Other
          def self.example(i=nil)
            message = OtherInputMessage.new
            message.metadata.source_event_stream_name = StreamName::Input.example
            message.metadata.source_event_position = StreamPosition.example i
            message
          end

          module EventData
            def self.example
              type = Type.example

              EventSource::Controls::EventData::Read.example(
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
