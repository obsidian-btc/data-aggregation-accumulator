require_relative '../automated_init'

context "Position Store, Output Stream Exists" do
  input_stream_name = Controls::StreamName::Input.example

  output_stream_name = Controls::Writer::Output.write version: 1
  output_category = EventStore::Messaging::StreamName.get_category output_stream_name

  position_store = Controls::PositionStore::Example.new input_stream_name
  position_store.output_category = output_category
  position_store.configure

  context "Get position" do
    position = position_store.get

    test "Global position stored on last output message is returned" do
      control_position = Controls::Messages::Input::GlobalPosition.example 1

      assert position == control_position
    end
  end
end
