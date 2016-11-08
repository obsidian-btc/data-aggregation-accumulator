require_relative '../automated_init'

context "Dispatcher Handles Input Message that Has Already Been Applied" do
  dispatcher = Controls::Dispatcher.example

  dispatcher.dispatch Controls::Messages::Input::Initial.example

  test "Nothing is written to output stream" do
    refute dispatcher.writer do
      written?
    end
  end

  test "Nothing is stored in cache" do
    refute dispatcher.cache do
      put?
    end
  end
end
