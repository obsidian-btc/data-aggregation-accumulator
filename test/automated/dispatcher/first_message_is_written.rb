require_relative '../automated_init'

context "Dispatcher Writes First Message to Output Stream" do
  dispatcher = Dispatcher.new(
    Controls::Projection::Example,
    Controls::Messages::Output::SomeMessage,
    Controls::StreamName::Output::Category.example
  )

  input_message = Controls::Messages::Input.example

  dispatcher.dispatch input_message

  test "Output message is written" do
    output_message = Controls::Messages::Output.example

    assert dispatcher.writer do
      written? do |message|
        output_message == message
      end
    end
  end

  test "Write is expected to initiate stream" do
    assert dispatcher.writer do
      written? do |_, _, expected_version|
        expected_version == :no_stream
      end
    end
  end

  test "Cache version is set to zero" do
    control_id = Controls::ID.example

    assert dispatcher.cache do
      put? do |record|
        record.version == 0
      end
    end
  end
end
