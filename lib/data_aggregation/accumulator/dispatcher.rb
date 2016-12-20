module DataAggregation::Accumulator
  module Dispatcher
    def self.included(cls)
      cls.class_exec do
        include EventStore::Messaging::StreamName
        include Log::Dependency

        extend Build
        extend ProjectionMacro
        extend OutputMessageMacro

        configure :dispatcher

        attr_writer :category_name

        dependency :cache, EntityCache
        dependency :session, EventStore::Client::HTTP::Session
        dependency :writer, EventStore::Messaging::Writer
      end
    end

    def build_message(event_data)
      projection_class.build_message event_data
    end

    def dispatch(input_message, event_data)
      logger.trace "Dispatching input message (InputMessageType: #{input_message.message_type})"

      stream_id, stream_position = parse_source_event_uri input_message.metadata
      global_position = event_data.position

      message, preceding_version = get_preceding_message stream_id

      if message.applied? stream_position
        logger.debug "Input message already applied; skipped (InputMessageType: #{input_message.message_type}, InputStreamPosition: #{stream_position}, MessageSourceStreamVersion: #{message.source_stream_version}, GlobalPosition: #{global_position})"
        return
      end

      message.source_stream_version = stream_position
      message.source_global_position = global_position

      output_stream_name = stream_name stream_id

      projection = projection_class.build message, output_stream_name, session: session
      projection.apply input_message

      writer.write message, output_stream_name, expected_version: preceding_version

      next_version = preceding_version == :no_stream ? 0 : preceding_version.next
      cache.put stream_id, message, next_version

      logger.info "Next message written (InputMessageType: #{input_message.message_type}, InputStreamPosition: #{stream_position}, OutputMessageType: #{message.message_type}, OutputStreamName: #{output_stream_name}, Version: #{next_version}, GlobalPosition: #{global_position})"

      message
    end

    def get_preceding_message(stream_id)
      logger.trace "Getting preceding output message (StreamID: #{stream_id})"

      cache_record = cache.get stream_id

      if cache_record
        preceding_message = cache_record.entity
        preceding_version = cache_record.version

        logger.debug "Preceding message found in cache (StreamID: #{stream_id}, CachedVersion: #{preceding_version})"
        return preceding_message, preceding_version
      end

      reader = build_reader stream_id

      reader.each do |event_data|
        preceding_message = build_output_message event_data
        preceding_version = event_data.number
        break
      end

      preceding_version ||= :no_stream
      preceding_message ||= output_message_class.new

      logger.debug "Preceding message read from output stream (StreamID: #{stream_id}, PrecedingVersion: #{preceding_version.inspect})"

      return preceding_message, preceding_version
    end

    def build_output_message(event_data)
      EventStore::Messaging::Message::Import::EventData.(
        event_data,
        output_message_class
      )
    end

    def build_reader(stream_id)
      output_stream_name = stream_name stream_id

      EventStore::Client::HTTP::Reader.build(
        output_stream_name,
        session: session,
        slice_size: 1,
        direction: :backward
      )
    end

    def parse_source_event_uri(metadata)
      logger.trace "Parsing source event URI (SourceEventURI: #{metadata.source_event_uri.inspect})"

      source_event_uri = URI.parse metadata.source_event_uri

      *, stream_name, stream_position = source_event_uri.path.split '/'

      stream_position = stream_position.to_i

      stream_id = EventStore::Messaging::StreamName.get_id stream_name

      logger.debug "Parsed source event URI (SourceEventURI: #{metadata.source_event_uri.inspect}, StreamID: #{stream_id.inspect}, StreamPosition: #{stream_position})"

      return stream_id, stream_position
    end

    module Build
      def build(session: nil)
        instance = new

        session = EventStore::Client::HTTP::Session.configure instance, session: session

        EntityCache.configure instance, projection_class, attr_name: :cache
        EventStore::Messaging::Writer.configure instance, session: session
        instance
      end
    end

    module ProjectionMacro
      def projection_macro(projection_class)
        define_singleton_method :projection_class do
          projection_class
        end

        define_method :projection_class do
          self.class.projection_class
        end
      end
      alias_method :projection, :projection_macro
    end

    module OutputMessageMacro
      def output_message_macro(output_message_class)
        define_singleton_method :output_message_class do
          output_message_class
        end

        define_method :output_message_class do
          self.class.output_message_class
        end
      end
      alias_method :output_message, :output_message_macro
    end
  end
end
