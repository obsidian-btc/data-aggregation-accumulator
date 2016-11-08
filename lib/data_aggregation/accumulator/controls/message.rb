module DataAggregation::Accumulator
  module Controls
    module Message
      def self.example(i=nil)
        i ||= 0

        result = Result.example i
        previous_result = Result.previous i

        message = SomeMessage.new
        message.result = result
        message.previous_result = previous_result
        message.source_stream_version = SourceStreamVersion.example i
        message
      end

      module Initial
        def self.example
          SomeMessage.new
        end
      end

      module Result
        def self.example(i=nil)
          i ||= 0

          value = 0

          (1..i).each do |index|
            value += index
          end

          value
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

      module SourceStreamVersion
        def self.example(i=nil)
          InputMessage::StreamPosition.example i
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
