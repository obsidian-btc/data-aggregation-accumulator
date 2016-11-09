module DataAggregation
  module Accumulator
    def self.included(cls)
      return if cls == Object

      cls.class_exec do
        include EventStore::Consumer

        extend DispatcherClass
        extend OutputMessageMacro
        extend OutputCategoryMacro
        extend ProjectionMacro

        position_store PositionStore
      end
    end

    module DispatcherClass
      def dispatcher_class
        @dispatcher_class ||= Class.new do
          include Dispatcher
        end
      end
      alias_method :messaging_dispatcher_class, :dispatcher_class
    end

    module OutputMessageMacro
      def output_message_macro(output_message_class)
        dispatcher_class.output_macro output_message_class
      end
      alias_method :output_message, :output_message_macro
    end

    module OutputCategoryMacro
      def output_category_macro(category_name)
        dispatcher_class.category category_name
      end
      alias_method :output_category, :output_category_macro
    end

    module ProjectionMacro
      def projection_macro(projection_class)
        dispatcher_class.projection_macro projection_class
      end
      alias_method :projection, :projection_macro
    end
  end
end
