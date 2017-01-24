require_relative '../automated_init'

context "Accumulator Module Output Message Macro" do
  accumulator = Controls::Accumulator.example

  test "Message class is set on dispatcher" do
    dispatcher = accumulator.dispatcher

    assert dispatcher.output_message_class == Controls::Messages::Output::SomeMessage
  end
end
