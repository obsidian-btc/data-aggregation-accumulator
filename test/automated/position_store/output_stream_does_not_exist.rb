require_relative '../automated_init'

context "Position Store, Output Stream Does Not Exist" do
  input_stream_name = Controls::StreamName::Input.example
  output_category = Controls::StreamName::Output::Category.example random: true

  position_store = Controls::PositionStore::Example.build
  position_store.output_category = output_category

  context "Get position" do
    position = position_store.get

    test "Nil is returned" do
      assert position == nil
    end
  end
end
