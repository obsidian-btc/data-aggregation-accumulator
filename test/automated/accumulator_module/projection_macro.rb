require_relative '../automated_init'

context "Accumulator Module Projection Macro" do
  accumulator = Controls::Accumulator.example

  dispatcher = accumulator.dispatcher

  test "Dispatcher is configured to use specified projection" do
    assert dispatcher.projection_class == Controls::Projection::Example
  end
end
