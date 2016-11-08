require_relative './interactive_init'

Actor::Supervisor.run do
  Controls::Accumulator::Example.start
end
