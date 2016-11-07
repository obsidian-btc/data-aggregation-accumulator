require_relative '../automated_init'

context "Position Store, Output Stream Exists" do
  stream_name = Controls::Writer::Output.write version: 1

  position_store = PositionStore.build stream_name

  context "Get position" do
    position = position_store.get

    test "No stream is returned" do
      assert position == 1
    end
  end
end
