require_relative '../automated_init'

context "Accumulate Reads Preceding Output Message from Stream (Cache Miss)" do
  input_message = Controls::Messages::Input::Current.example

  output_stream_name = Controls::Writer::Output.write

  category = Messaging::StreamName.get_category output_stream_name

  accumulate = Controls::Accumulate.example category, cache: false
  write = SubstAttr::Substitute.(:write, accumulate)

  output_message = accumulate.accumulate input_message

  test "Result is projected from last event written to output stream" do
    assert output_message == Controls::Messages::Output::Current.example
  end

  test "Expected version is set that of output stream" do
    assert write do
      written? do |_, _, expected_version|
        expected_version == Controls::Version::Output::Preceding.example
      end
    end
  end
end
