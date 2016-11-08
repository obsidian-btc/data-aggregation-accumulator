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
      source_event_uri = URI.parse input_message.metadata.source_event_uri

      *, stream_name, stream_position = source_event_uri.path.split '/'

      stream_position = stream_position.to_i

      category, stream_id = EventStore::Client::StreamName.split stream_name

      output_stream_name = stream_name stream_id

      message = nil
      version = :no_stream

      cache_record = cache.get stream_id

      if cache_record
        message = cache_record.entity
        version = cache_record.version
      end

      reader = EventStore::Client::HTTP::Reader.build(
        output_stream_name,
        slice_size: 1,
        direction: :backward
      )

      reader.each do |event_data|
        message = EventStore::Messaging::Message::Import::EventData.(
          event_data,
          entity_class
        )
        version = event_data.number
        break
      end

      message ||= entity_class.new
      message.source_stream_version = stream_position
      message.advance

      projection = projection_class.build message, output_stream_name
      projection.apply input_message

      writer.write message, output_stream_name, expected_version: version

      next_version = version == :no_stream ? 0 : version.next
      cache.put stream_id, message, next_version

      message
    end
  end
end
