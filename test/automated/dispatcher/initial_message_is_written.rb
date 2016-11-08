require_relative '../automated_init'

context "Dispatcher Writes Initial Message to Output Stream" do
  input_message = Controls::Messages::Input::Initial.example

  dispatcher = Controls::Dispatcher.example cache: false

  output_message = dispatcher.dispatch input_message

  test "Initial output message is written" do
    assert output_message == Controls::Messages::Output::Initial.example
  end

  test "Write is expected to initiate the stream" do
    assert dispatcher.writer do
      written? do |_, _, expected_version|
        expected_version == :no_stream
      end
    end
  end
end
