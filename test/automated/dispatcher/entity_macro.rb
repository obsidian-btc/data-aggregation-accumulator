require_relative '../automated_init'

context "Dispatcher Entity Macro" do
  dispatcher_class = Class.new do
    include DataAggregation::Accumulator::Dispatcher

    entity Controls::Messages::Output::SomeMessage
  end

  dispatcher = dispatcher_class.new

  context "Entity class is queried" do
    entity_class = dispatcher.entity_class

    test "Specified entity class is returned" do
      assert entity_class == Controls::Messages::Output::SomeMessage
    end
  end
end
