require_relative '../automated_init'

context "Dispatcher Output Message Macro" do
  dispatcher_class = Class.new do
    include DataAggregation::Accumulator::Dispatcher

    output_message Controls::Messages::Output::SomeMessage
  end

  dispatcher = dispatcher_class.new

  context "Output message class is queried" do
    output_message_class = dispatcher.output_message_class

    test "Specified output message class is returned" do
      assert output_message_class == Controls::Messages::Output::SomeMessage
    end
  end
end
