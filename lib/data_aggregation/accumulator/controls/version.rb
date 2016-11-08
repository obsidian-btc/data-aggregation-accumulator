module DataAggregation::Accumulator
  module Controls
    module Version
      module Output
        def self.example
          Current.example
        end

        module Preceding
          def self.example
            10
          end
        end

        module Current
          def self.example
            11
          end
        end
      end
    end
  end
end
