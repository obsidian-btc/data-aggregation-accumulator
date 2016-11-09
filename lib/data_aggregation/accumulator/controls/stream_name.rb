module DataAggregation::Accumulator
  module Controls
    module StreamName
      def self.get(category, stream_id=nil)
        stream_id ||= Controls::ID.example

        EventStore::Messaging::StreamName.stream_name stream_id, category
      end

      def self.category(category, random: nil)
        random = SecureRandom.hex 7 if random == true

        "#{category}#{random}"
      end

      module Input
        def self.example(random: nil)
          category = Category.example random: random

          StreamName.get category
        end

        module Category
          def self.example(random: nil)
            StreamName.category 'someStream', random: random
          end

          def self.event_store
            category = self.example

            EventStore::Messaging::StreamName.category_stream_name category
          end
        end
      end

      module Output
        def self.example(stream_id: nil, random: nil)
          category = Category.example random: random

          StreamName.get category, stream_id
        end

        module Category
          def self.example(random: nil)
            StreamName.category 'someAccumulator', random: random
          end
        end
      end
    end
  end
end
