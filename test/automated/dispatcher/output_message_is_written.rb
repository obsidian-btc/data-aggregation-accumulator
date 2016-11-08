require_relative '../automated_init'

context "Dispatcher Writes Output Message" do
  dispatcher = Controls::Dispatcher.example

  dispatcher.dispatch Controls::Messages::Input::Current.example

  test "Output message is written to output stream" do
    control_message = Controls::Messages::Output::Current.example
    output_stream_name = Controls::StreamName::Output.example

    assert dispatcher.writer do
      written? do |msg, stream_name|
        msg == control_message && stream_name == output_stream_name
      end
    end
  end

  test "Expected version is set" do
    assert dispatcher.writer do
      written? do |_, _, expected_version|
        expected_version == Controls::Version::Output::Preceding.example
      end
    end
  end
end
