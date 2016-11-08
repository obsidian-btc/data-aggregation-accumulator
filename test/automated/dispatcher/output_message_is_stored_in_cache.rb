require_relative '../automated_init'

context "Dispatcher Stores Output Message in Entity Cache" do
  input_message = Controls::Messages::Input::Current.example

  dispatcher = Controls::Dispatcher.example

  output_message = dispatcher.dispatch input_message

  test "ID of cache record matches that of stream" do
    assert dispatcher.cache do
      put? { |record| record.id == Controls::ID.example }
    end
  end

  test "Cache record includes output message written by dispatcher" do
    assert dispatcher.cache do
      put? { |record| record.entity == output_message }
    end
  end

  test "Version of cache record matches the output message version" do
    assert dispatcher.cache do
      put? { |record| record.version == Controls::Version::Output.example }
    end
  end
end
