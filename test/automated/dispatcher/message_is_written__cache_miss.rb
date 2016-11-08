require_relative '../automated_init'

context "Dispatcher Writes Message to Output Stream, Cache Miss" do
  version = 11
  output_stream_name = Controls::Writer::Output.write version: version.pred
  input_message = Controls::InputMessage.example version
  output_message = Controls::Message.example version

  category = EventStore::Messaging::StreamName.get_category output_stream_name

  dispatcher = Dispatcher.new(
    Controls::Projection::Example,
    Controls::Message::SomeMessage,
    category
  )

  dispatcher.dispatch input_message

  test "Message is written to output stream" do
    assert dispatcher.writer do
      written? do |msg, stream_name|
        msg == output_message && stream_name == output_stream_name
      end
    end
  end

  test "Expected version is set" do
    assert dispatcher.writer do
      written? do |_, _, expected_version|
        expected_version == version.pred
      end
    end
  end

  test "Message is put in the cache" do
    control_id = Controls::ID.example

    assert dispatcher.cache do
      put? do |record|
        record.id == control_id && record.entity == output_message && record.version == version
      end
    end
  end
end
