require_relative '../automated_init'

context "Accumulate Stores Output Message in Entity Cache" do
  input_message = Controls::Messages::Input::Current.example

  accumulate = Controls::Accumulate.example
  SubstAttr::Substitute.(:write, accumulate)

  output_message = accumulate.accumulate input_message

  test "ID of cache record matches that of stream" do
    assert accumulate.cache do
      put? { |record| record.id == Controls::ID.example }
    end
  end

  test "Cache record includes output message written by accumulate" do
    assert accumulate.cache do
      put? { |record| record.entity == output_message }
    end
  end

  test "Version of cache record matches the output message version" do
    assert accumulate.cache do
      put? { |record| record.version == Controls::Version::Output.example }
    end
  end
end
