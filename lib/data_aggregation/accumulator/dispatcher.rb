module DataAggregation::Accumulator
  module Dispatcher
    def self.included(cls)
      cls.class_exec do
        include Messaging::StreamName
        include Log::Dependency

        include EventStore::Consumer::Dispatcher

        extend Build
        extend ProjectionMacro
        extend OutputMessageMacro

        configure :dispatcher

        attr_writer :category

        dependency :cache, EntityCache
        dependency :session, EventSource::EventStore::HTTP::Session
        dependency :write, Messaging::EventStore::Write
      end
    end

    def build_message(event_data)
      projection_class.build_message event_data
    end

    def dispatch(input_message, _=nil)
      logger.trace "Dispatching input message (InputMessageType: #{input_message.message_type})"

      stream_id = Messaging::StreamName.get_id input_message.metadata.source_event_stream_name
      stream_position = input_message.metadata.position
      global_position = input_message.metadata.global_position

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

      write.(message, output_stream_name, expected_version: preceding_version)

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

      output_stream_name = stream_name stream_id

      get = EventSource::EventStore::HTTP::Get.build(
        session: session,
        batch_size: 1,
        precedence: :desc
      )

      event_data, * = get.(output_stream_name)

      unless event_data.nil?
        preceding_message = build_output_message event_data
        preceding_version = event_data.position
      end

      preceding_version ||= :no_stream
      preceding_message ||= output_message_class.new

      logger.debug "Preceding message read from output stream (StreamID: #{stream_id}, PrecedingVersion: #{preceding_version.inspect})"

      return preceding_message, preceding_version
    end

    def build_output_message(event_data)
      Messaging::Message::Import.(
        event_data,
        output_message_class
      )
    end

    module Build
      def build(session: nil)
        instance = new

        session = EventSource::EventStore::HTTP::Session.configure instance, session: session

        EntityCache.configure instance, projection_class, attr_name: :cache
        Messaging::EventStore::Write.configure instance, session: session
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
