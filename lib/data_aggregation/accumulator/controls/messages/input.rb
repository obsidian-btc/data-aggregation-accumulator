module DataAggregation::Accumulator
  module Controls
    module Messages
      module Input
        def self.example(i=nil)
          message = SomeInputMessage.new
          message.number = Number.example i

          message.metadata.source_event_stream_name = StreamName::Input.example
          message.metadata.source_event_position = StreamPosition.example i
          message.metadata.global_position = GlobalPosition.example i

          message
        end

        module Initial
          def self.example
            Input.example 0
          end

          def self.pair
            message = self.example
            event_data = EventData.example

            return message, event_data
          end

          module EventData
            def self.example
              Input::EventData.example 0
            end
          end
        end

        module Current
          def self.example
            i = Version::Output::Current.example

            Input.example i
          end

          def self.pair
            message = self.example
            event_data = EventData.example

            return message, event_data
          end

          module EventData
            def self.example
              i = Version::Output::Current.example

              Input::EventData.example i
            end
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

        module GlobalPosition
          def self.example(i=nil)
            stream_position = StreamPosition.example i

            "#{stream_position}#{stream_position}".to_i
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
