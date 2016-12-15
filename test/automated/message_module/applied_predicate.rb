require_relative '../automated_init'

context "Message Module Applied Predicate" do
  message = Controls::Messages::Output.example
  message.source_stream_version = 1

  context "Specified version precedes source stream version" do
    test "Predicate returns true" do
      assert message.applied?(0)
    end
  end

  context "Specified version matches source stream version" do
    test "Predicate returns true" do
      assert message.applied?(1)
    end
  end

  context "Specified version follows source stream version" do
    test "Predicate returns false" do
      refute message.applied?(2)
    end
  end
end
