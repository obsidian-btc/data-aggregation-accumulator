require_relative '../automated_init'

context "Dispatcher Builds Message, Projection Does Not Apply Message" do
  dispatcher = Controls::Dispatcher.example

  event_data = Controls::Messages::Input::Other::EventData.example

  message = dispatcher.build_message event_data

  test "Nothing is returned" do
    assert message.nil?
  end
end
