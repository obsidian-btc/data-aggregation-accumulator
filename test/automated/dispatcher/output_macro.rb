require_relative '../automated_init'

context "Dispatcher Output Macro" do
  dispatcher_class = Class.new do
    include DataAggregation::Accumulator::Dispatcher

    output Controls::Messages::Output::SomeMessage
  end

  dispatcher = dispatcher_class.new

  context "Output class is queried" do
    output_class = dispatcher.output_class

    test "Specified output class is returned" do
      assert output_class == Controls::Messages::Output::SomeMessage
    end
  end
end
