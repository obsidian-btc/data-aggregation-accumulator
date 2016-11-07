module DataAggregation::Accumulator
  module Controls
    module StreamName
      module Output
        def self.example(random: nil)
          category = Category.example random: random
          stream_id = Controls::ID.example

          EventStore::Messaging::StreamName.stream_name stream_id, category
        end

        module Category
          def self.example(random: nil)
            random = SecureRandom.hex 7 if random == true

            "someAccumulator#{random}"
          end
        end
      end
    end
  end
end
