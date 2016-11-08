require_relative '../automated_init'

context "Message Module Applied Predicate" do
  message = Controls::Messages::Output.example
  message.source_stream_version = Controls::SourceStreamVersion.example

  context "Specified version precedes source stream version" do
    test "Predicate returns true" do
      assert message.applied?(Controls::SourceStreamVersion::Preceding.example)
    end
  end

  context "Specified version matches source stream version" do
    test "Predicate returns true" do
      assert message.applied?(Controls::SourceStreamVersion.example)
    end
  end

  context "Specified version follows source stream version" do
    test "Predicate returns false" do
      refute message.applied?(Controls::SourceStreamVersion::Following.example)
    end
  end
end
