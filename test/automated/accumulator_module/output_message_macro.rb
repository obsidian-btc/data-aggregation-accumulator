require_relative '../automated_init'

context "Accumulator Module Output Message Macro" do
  accumulator = Controls::Accumulator.example

  test "Message class is set on accumulate" do
    accumulate = accumulator.accumulate

    assert accumulate.output_message_class == Controls::Messages::Output::SomeMessage
  end
end
