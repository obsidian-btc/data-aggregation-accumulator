require_relative '../automated_init'

context "Dispatcher Category Macro" do
  dispatcher_class = Class.new do
    include DataAggregation::Accumulator::Dispatcher

    category :some_category
  end

  dispatcher = dispatcher_class.new

  context "Category name is queried" do
    category_name = dispatcher.category

    test "Specified category is returned" do
      assert category_name == 'someCategory'
    end
  end
end
