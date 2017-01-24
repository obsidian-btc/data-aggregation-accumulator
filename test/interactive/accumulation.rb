require_relative './interactive_init'

output_version = (ENV['OUTPUT_VERSION'] || '100').to_i

stream_id = Identifier::UUID::Random.get
category = Controls::StreamName::Input::Category.example

input_stream_name = Controls::Writer::Input.write(
  category,
  stream_id: stream_id,
  output_version: output_version
)

output_stream_name = Controls::StreamName::Output.example stream_id: stream_id

expect_message = Fixtures::ExpectMessage.build output_stream_name

(0..output_version).each do |i|
  expected_result = Controls::Messages::Output::Result.example i

  expect_message.(['SomeMessage']) do |data|
    data[:result] == expected_result

    Log.get(__FILE__).info "Verified event (Counter: #{i})"
  end
end
