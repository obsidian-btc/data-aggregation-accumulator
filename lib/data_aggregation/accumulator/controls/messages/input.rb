module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        def self.example(i=nil, source_event_uri: nil)
          message = SomeInputMessage.new
          message.number = Number.example i
          message.metadata.source_event_uri = SourceEventURI.example i
          message
        end

        module Initial
          def self.example
            Input.example 0
          end
        end

        module Current
          def self.example
            i = Version::Output::Current.example

            Input.example i
          end
        end

        module Number
          def self.example(i=nil)
            i || 0
          end
        end

        module StreamPosition
          def self.example(i=nil)
            i ||= 0

            i * 2 + 1
          end

          def self.initial
            example
          end
        end

        class SomeInputMessage
          include EventStore::Messaging::Message

          attribute :number, Integer
        end
      end
    end
  end
end
