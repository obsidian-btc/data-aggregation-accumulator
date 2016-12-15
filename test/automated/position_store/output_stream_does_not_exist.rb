require_relative '../automated_init'

context "Position Store, Output Stream Does Not Exist" do
  input_stream_name = Controls::StreamName::Input.example
  output_category = Controls::StreamName::Output::Category.example random: true

  position_store = Controls::PositionStore::Example.build input_stream_name
  position_store.category_name = output_category

  context "Get position" do
    position = position_store.get

    test "No stream is returned" do
      assert position == :no_stream
    end
  end
end
