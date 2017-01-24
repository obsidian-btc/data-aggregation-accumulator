require_relative '../automated_init'

context "Dispatcher, Session Is Supplied At Construction" do
  session = EventSource::EventStore::HTTP::Session.build

  dispatcher = Controls::Dispatcher::Example.build session: session

  test "Session is supplied to event writer" do
    assert dispatcher.write.event_writer do |write|
      session?(session)
    end
  end
end
