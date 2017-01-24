require_relative '../automated_init'

context "Accumulator Module Output Category Macro" do
  accumulator = Controls::Accumulator.example

  test "Category is set on position store" do
    position_store = accumulator.position_store

    assert position_store.output_category == Controls::StreamName::Output::Category.example
  end

  test "Category is set on dispatcher" do
    dispatcher = accumulator.dispatcher

    assert dispatcher.output_category == Controls::StreamName::Output::Category.example
  end
end
