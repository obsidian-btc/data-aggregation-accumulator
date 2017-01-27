require_relative '../automated_init'

context "Accumulator Module Projection Macro" do
  accumulator = Controls::Accumulator.example

  accumulate = accumulator.accumulate

  test "Accumulate is configured to use specified projection" do
    assert accumulate.projection_class == Controls::Projection::Example
  end
end
