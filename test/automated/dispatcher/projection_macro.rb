require_relative '../automated_init'

context "Dispatcher Projection Macro" do
  dispatcher_class = Class.new do
    include DataAggregation::Accumulator::Dispatcher

    projection Controls::Projection::Example
  end

  dispatcher = dispatcher_class.new

  context "Projection class is queried" do
    projection_class = dispatcher.projection_class

    test "Specified projection class is returned" do
      assert projection_class == Controls::Projection::Example
    end
  end
end
