module DataAggregation::Accumulator
  module Controls
    module Messages
      module Output
        def self.example(i=nil)
          i ||= 0

          result = Result.example i
          previous_result = Result.previous i

          message = SomeMessage.new
          message.result = result
          message.previous_result = previous_result
          message.source_stream_version = Input::StreamPosition.example i
          message.source_global_position = Input::GlobalPosition.example i
          message
        end

        module Initial
          def self.example
            version = 0

            Output.example version
          end
        end

        module Preceding
          def self.example
            version = Version::Output::Preceding.example

            Output.example version
          end
        end

        module Current
          def self.example
            version = Version::Output.example

            Output.example version
          end
        end

        module Result
          def self.example(i=nil)
            i ||= 0

            result = 0

            (1..i).each do |_i|
              result += _i
            end

            result
          end

          def self.previous(i=nil)
            i ||= 0

            if i == 0
              0
            else
              example i - 1
            end
          end
        end

        class SomeMessage
          include DataAggregation::Accumulator::Message

          attribute :result, Integer
          attribute :previous_result, Integer, default: 0

          def advance
            self.previous_result = result
            self.result = nil
          end
        end
      end
    end
  end
end
