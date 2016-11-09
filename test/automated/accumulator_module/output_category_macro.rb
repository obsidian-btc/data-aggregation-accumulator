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
end
