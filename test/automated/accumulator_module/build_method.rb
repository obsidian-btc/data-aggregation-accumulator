require_relative '../automated_init'

context "Accumulator Module Build Method" do
  accumulator = Controls::Accumulator::Example.build

  test "Position store is configured" do
    assert accumulator.position_store do
      instance_of? PositionStore
    end
  end

  test "Stream name is configured" do
    control_stream_name = Controls::StreamName::Input::Category.event_store

    assert accumulator.stream_name == control_stream_name
  end
end
