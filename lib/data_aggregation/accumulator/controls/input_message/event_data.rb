module DataAggregation::Accumulator
  module Controls
    module InputMessage
      module EventData
        def self.example(number=nil)
          EventStore::Client::HTTP::Controls::EventData::Read.example(
            type: 'SomeInputMessage',
            data: { :number => Number.example },
            metadata: false
          )
        end

        module Other
          def self.example
            EventStore::Client::HTTP::Controls::EventData::Read.example(
              type: 'OtherInputMessage',
              data: { :some_attribute => 'some-value', },
              metadata: false
            )
          end
        end
      end
    end
  end
end
