module DataAggregation::Accumulator
  module Controls
    module Writer
      module Output
        def self.write(version: nil)
          version ||= 0

          stream_name = StreamName::Output.example random: true

          event_batch = (0..version).map do |event_version|
            Message.example event_version
          end

          writer = EventStore::Messaging::Writer.build
          writer.write_initial event_batch, stream_name

          stream_name
        end
      end
    end
  end
end
