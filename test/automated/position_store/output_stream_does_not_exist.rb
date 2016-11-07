require_relative '../automated_init'

context "Position Store, Output Stream Does Not Exist" do
  stream_name = Controls::StreamName::Output.example random: true

  position_store = PositionStore.build stream_name

  context "Get position" do
    position = position_store.get

    test "No stream is returned" do
      assert position == :no_stream
    end
  end
end
