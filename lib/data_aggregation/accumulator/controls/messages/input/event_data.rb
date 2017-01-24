module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        module EventData
          def self.example(i=nil)
            type = Type.example
            number = Number.example i
            position = GlobalPosition.example i

            event_data = ::EventSource::Controls::EventData::Read.example(
              type: type,
              data: { :number => number },
              metadata: false
            )
            event_data.position = number
            event_data.global_position = position
            event_data
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
