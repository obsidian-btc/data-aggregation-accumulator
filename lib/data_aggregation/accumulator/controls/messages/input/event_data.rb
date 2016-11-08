module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module EventData
          def self.example(i=nil)
            type = Type.example
            number = Number.example i

            EventStore::Client::HTTP::Controls::EventData::Read.example(
              type: type,
              data: { :number => number },
              metadata: false
            )
          end

          module Type
            def self.example
              SomeInputMessage.message_type
            end
          end
        end
      end
    end
  end
end
