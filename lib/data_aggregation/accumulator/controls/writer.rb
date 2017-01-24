module DataAggregation::Accumulator
  module Controls
    module Writer
      module Input
        def self.write(category=nil, stream_id: nil, output_version: nil)
          output_version ||= Version::Output.example
          category ||= StreamName::Input::Category.example random: true
          stream_id ||= ID.example

          stream_name = Messaging::StreamName.stream_name stream_id, category

          write = Messaging::EventStore::Write.build

          (0..output_version).each do |i|
            batch = [
              Messages::Input::Other.example(i),
              Messages::Input.example(i)
            ]

            write.(batch, stream_name)
          end

          stream_name
        end
      end

      module Output
        def self.write(version: nil)
          version ||= Version::Output::Preceding.example

          stream_name = StreamName::Output.example random: true

          event_batch = (0..version).to_a.map do |event_version|
            Messages::Output.example event_version
          end

          write = Messaging::EventStore::Write.build
          write.initial event_batch, stream_name

          stream_name
        end
      end
    end
  end
end
