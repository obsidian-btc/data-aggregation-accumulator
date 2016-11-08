require_relative '../automated_init'

context "Dispatcher Builds Message, Projection Applies Message" do
  dispatcher = Dispatcher.new(
    Controls::Projection::Example,
    Controls::Message::SomeMessage,
    'someCategory'
  )

  event_data = Controls::InputMessage::EventData.example

  message = dispatcher.build_message event_data

  test "Message is returned" do
    assert message == Controls::InputMessage.example
  end
end
