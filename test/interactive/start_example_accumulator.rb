require_relative './interactive_init'

Actor::Supervisor.start do
  category = Controls::StreamName::Input::Category.example

  Controls::Accumulator::Example.start category
end
