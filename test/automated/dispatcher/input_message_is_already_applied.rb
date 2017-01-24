require_relative '../automated_init'

context "Dispatcher Handles Input Message that Has Already Been Applied" do
  input_message = Controls::Messages::Input::Initial.example

  dispatcher = Controls::Dispatcher.example

  write = SubstAttr::Substitute.(:write, dispatcher)

  dispatcher.dispatch input_message

  test "Nothing is written to output stream" do
    refute write do
      written?
    end
  end

  test "Nothing is stored in cache" do
    refute dispatcher.cache do
      put?
    end
  end
end
