require_relative '../automated_init'

context "Dispatcher Builds Message, Projection Applies Message" do
  dispatcher = Dispatcher.new(
    Controls::Projection::Example,
    Controls::Messages::Output::SomeMessage,
    'someCategory'
  )

  event_data = Controls::Messages::Input::EventData.example

  message = dispatcher.build_message event_data

  test "Message is returned" do
    assert message == Controls::Messages::Input.example
  end
end
