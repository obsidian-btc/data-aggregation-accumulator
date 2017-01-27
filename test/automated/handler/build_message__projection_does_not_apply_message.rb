require_relative '../automated_init'

context "Accumulate Builds Message, Projection Does Not Apply Message" do
  accumulate = Controls::Accumulate.example

  event_data = Controls::Messages::Input::Other::EventData.example

  message = accumulate.build_message event_data

  test "Nothing is returned" do
    assert message.nil?
  end
end
