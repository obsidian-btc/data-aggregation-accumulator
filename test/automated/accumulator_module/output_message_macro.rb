require_relative '../automated_init'

context "Accumulator Module Output Message Macro" do
  accumulator_class = Class.new do
    include DataAggregation::Accumulator

    output_message Controls::Messages::Output::SomeMessage
  end

  test "Dispatcher is configured to use specified output class" do
    assert accumulator_class.dispatcher_class do
      output_class == Controls::Messages::Output::SomeMessage
    end
  end
end
