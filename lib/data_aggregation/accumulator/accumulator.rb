module DataAggregation
  module Accumulator
    def self.included(cls)
      return if cls == Object

      cls.class_exec do
        include Consumer::EventStore
        include EventStore::Consumer::ErrorHandler

        include Configure

        extend OutputMessageMacro
        extend OutputCategoryMacro
        extend ProjectionMacro

        extend SpecializedPositionStoreClass

        const_set :PositionStore, specialized_position_store_class

        dependency :dispatcher, Dispatcher
      end
    end

    module Configure
      def configure(session: nil, **)
        dispatcher = Dispatcher.configure(
          self,
          output_category,
          output_message_class,
          projection_class,
          session: session
        )

        self.class.handler_registry.register dispatcher

        self.class.specialized_position_store_class.configure self

        super
      end
    end

    module OutputMessageMacro
      def output_message_macro(output_message_class)
        define_method :output_message_class do
          output_message_class
        end
      end
      alias_method :output_message, :output_message_macro
    end

    module OutputCategoryMacro
      def output_category_macro(category_name)
        category_name = Casing::Camel.(category_name.to_s)

        define_method :output_category do
          category_name
        end

        specialized_position_store_class.output_category = category_name
      end
      alias_method :output_category, :output_category_macro
    end

    module ProjectionMacro
      def projection_macro(projection_class)
        define_method :projection_class do
          projection_class
        end
      end
      alias_method :projection, :projection_macro
    end

    module SpecializedPositionStoreClass
      def specialized_position_store_class
        @specialized_position_store_class ||= Class.new do
          include PositionStore
        end
      end
    end
  end
end
