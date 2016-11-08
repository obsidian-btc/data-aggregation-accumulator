require_relative '../automated_init'

context "Message is Instantiated" do
  message = Controls::Messages::Output::SomeMessage.new

  test "Instances are event store messages" do
    assert message.is_a?(EventStore::Messaging::Message)
  end

  test "Advance method is implemented as a no-op" do
    refute proc { message.advance } do
      raises_error?
    end
  end

  test "Source stream version is initialized to -1" do
    assert message.source_stream_version == -1
  end
end
