require_relative '../automated_init'

context "Dispatcher, Session Is Supplied At Construction" do
  session = Object.new

  dispatcher = Controls::Dispatcher::Example.build session: session

  test "Session is supplied to writer" do
    assert dispatcher.writer do |writer|
      writer.writer.request.session == session
    end
  end
end
