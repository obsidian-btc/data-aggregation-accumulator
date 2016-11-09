require_relative '../automated_init'

context "Accumulator Module Projection Macro" do
  accumulator_class = Class.new do
    include DataAggregation::Accumulator

    projection Controls::Projection::Example
  end

  test "Dispatcher is configured to use specified projection" do
    assert accumulator_class.dispatcher_class do
      projection_class == Controls::Projection::Example
    end
  end
end
