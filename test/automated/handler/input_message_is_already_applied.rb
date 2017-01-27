require_relative '../automated_init'

context "Accumulate Handles Input Message that Has Already Been Applied" do
  input_message = Controls::Messages::Input::Initial.example

  accumulate = Controls::Accumulate.example

  write = SubstAttr::Substitute.(:write, accumulate)

  accumulate.accumulate input_message

  test "Nothing is written to output stream" do
    refute write do
      written?
    end
  end

  test "Nothing is stored in cache" do
    refute accumulate.cache do
      put?
    end
  end
end
