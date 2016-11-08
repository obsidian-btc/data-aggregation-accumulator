module DataAggregation::Accumulator
  module Controls
    module InputMessage
      def self.example(i=nil, source_event_uri: nil)
        source_event_uri ||= SourceEventURI.example i

        message = SomeInputMessage.new
        message.number = Number.example i
        message.metadata.source_event_uri = source_event_uri if source_event_uri
        message
      end

      module Number
        def self.example(i=nil)
          i ||= 0
          i
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

      class Other
        include EventStore::Messaging::Message

        attribute :some_attribute
      end
    end
  end
end
