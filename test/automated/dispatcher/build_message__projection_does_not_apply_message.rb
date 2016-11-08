require_relative '../automated_init'

context "Dispatcher Builds Message, Projection Does Not Apply Message" do
  dispatcher = Dispatcher.new(
    Controls::Projection::Example,
    Controls::Message::SomeMessage,
    'someCategory'
  )

  event_data = Controls::InputMessage::EventData::Other.example

  message = dispatcher.build_message event_data

  test "Nothing is returned" do
    assert message.nil?
  end
end
