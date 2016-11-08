module DataAggregation::Accumulator
  class Dispatcher
    include EventStore::Messaging::StreamName

    dependency :cache, EntityCache
    dependency :writer, EventStore::Messaging::Writer

    initializer :projection_class, :entity_class, :category_name

    def self.build(projection_class, entity_class, output_category)
      instance = new projection_class, entity_class, output_category
      EntityCache.configure instance, projection_class, attr_name: :cache
      EventStore::Messaging::Writer.configure instance
      instance
    end

    def build_message(event_data)
      projection_class.build_message event_data
    end

    def dispatch(input_message, _=nil)
      stream_id, stream_position = parse_source_event_uri input_message.metadata

      message, preceding_version = get_preceding_message stream_id

      message.source_stream_version = stream_position
      message.advance

      output_stream_name = stream_name stream_id

      projection = projection_class.build message, output_stream_name
      projection.apply input_message

      writer.write message, output_stream_name, expected_version: preceding_version

      next_version = preceding_version == :no_stream ? 0 : preceding_version.next
      cache.put stream_id, message, next_version

      message
    end

    def get_preceding_message(stream_id)
      cache_record = cache.get stream_id

      if cache_record
        preceding_message = cache_record.entity
        preceding_version = cache_record.version
      else
        reader = build_reader stream_id

        reader.each do |event_data|
          preceding_message = build_output_message event_data
          preceding_version = event_data.number
          break
        end
      end

      preceding_version ||= :no_stream
      preceding_message ||= entity_class.new

      return preceding_message, preceding_version
    end

    def build_output_message(event_data)
      EventStore::Messaging::Message::Import::EventData.(
        event_data,
        entity_class
      )
    end

    def build_reader(stream_id)
      output_stream_name = stream_name stream_id

      EventStore::Client::HTTP::Reader.build(
        output_stream_name,
        slice_size: 1,
        direction: :backward
      )
    end

    def parse_source_event_uri(metadata)
      source_event_uri = URI.parse metadata.source_event_uri

      *, stream_name, stream_position = source_event_uri.path.split '/'

      stream_position = stream_position.to_i

      stream_id = EventStore::Messaging::StreamName.get_id stream_name

      return stream_id, stream_position
    end
  end
end
