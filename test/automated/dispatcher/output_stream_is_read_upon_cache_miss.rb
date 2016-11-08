require_relative '../automated_init'

context "Dispatcher Reads Preceding Output Message from Stream (Cache Miss)" do
  output_stream_name = Controls::Writer::Output.write
  category = EventStore::Messaging::StreamName.get_category output_stream_name

  dispatcher = Controls::Dispatcher.example category, cache: false

  output_message = dispatcher.dispatch Controls::Messages::Input::Current.example

  test "Result is projected from last event written to output stream" do
    assert output_message == Controls::Messages::Output::Current.example
  end

  test "Expected version is set that of output stream" do
    assert dispatcher.writer do
      written? do |_, _, expected_version|
        expected_version == Controls::Version::Output::Preceding.example
      end
    end
  end
end
