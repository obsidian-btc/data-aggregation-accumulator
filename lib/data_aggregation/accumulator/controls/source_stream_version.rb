module DataAggregation::Accumulator
  module Controls
    module SourceStreamVersion
      def self.example
        Current.example
      end

      module Preceding
        def self.example
          0
        end
      end

      module Current
        def self.example
          1
        end
      end

      module Following
        def self.example
          2
        end
      end
    end
  end
end
