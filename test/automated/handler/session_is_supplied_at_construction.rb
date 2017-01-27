require_relative '../automated_init'

context "Accumulate, Session Is Supplied At Construction" do
  session = EventSource::EventStore::HTTP::Session.build

  accumulate = Controls::Accumulate.example session: session

  test "Session is supplied to event writer" do
    assert accumulate.write.event_writer do |write|
      session?(session)
    end
  end
end
