require_relative '../automated_init'

context "Accumulate Writes Output Message" do
  input_message, input_event_data = Controls::Messages::Input::Current.pair

  accumulate = Controls::Accumulate.example
  SubstAttr::Substitute.(:write, accumulate)

  accumulate.accumulate input_message, input_event_data

  test "Output message is written to output stream" do
    control_message = Controls::Messages::Output::Current.example
    output_stream_name = Controls::StreamName::Output.example

    assert accumulate.write do
      written? do |msg, stream_name|
        msg == control_message && stream_name == output_stream_name
      end
    end
  end

  test "Expected version is set" do
    assert accumulate.write do
      written? do |_, _, expected_version|
        expected_version == Controls::Version::Output::Preceding.example
      end
    end
  end
end
