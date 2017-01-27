require_relative '../automated_init'

context "Accumulate Writes Initial Message to Output Stream" do
  input_message = Controls::Messages::Input::Initial.example

  accumulate = Controls::Accumulate.example cache: false

  write = SubstAttr::Substitute.(:write, accumulate)

  output_message = accumulate.accumulate input_message

  test "Initial output message is written" do
    assert output_message == Controls::Messages::Output::Initial.example
  end

  test "Write is expected to initiate the stream" do
    assert write do
      written? do |_, _, expected_version|
        expected_version == :no_stream
      end
    end
  end
end
