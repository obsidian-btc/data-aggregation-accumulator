require_relative '../automated_init'

context "Accumulator Module Entity Macro" do
  accumulator_class = Class.new do
    include DataAggregation::Accumulator

    entity Controls::Messages::Output::SomeMessage
  end

  test "Dispatcher is configured to use specified entity" do
    assert accumulator_class.dispatcher_class do
      entity_class == Controls::Messages::Output::SomeMessage
    end
  end
end
