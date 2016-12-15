require_relative '../automated_init'

context "Accumulator Module Output Category Macro" do
  accumulator_class = Class.new do
    include DataAggregation::Accumulator

    output_category :some_category
  end

  test "Dispatcher is configured to use specified category" do
    dispatcher = accumulator_class.dispatcher_class.new

    assert dispatcher do
      category_name == 'someCategory'
    end
  end

  test "Position store is configured to use specified category" do
    stream_name = Controls::StreamName::Input.example

    position_store = accumulator_class.position_store_class.new stream_name

    assert position_store do
      category_name == 'someCategory'
    end
  end
end
