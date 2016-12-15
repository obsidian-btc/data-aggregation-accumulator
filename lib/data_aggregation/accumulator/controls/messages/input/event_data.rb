module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module EventData
          def self.example(i=nil)
            type = Type.example
            number = Number.example i
            position = GlobalPosition.example i

            EventStore::Client::HTTP::Controls::EventData::Read.example(
              number,
              type: type,
              data: { :number => number },
              position: position,
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
