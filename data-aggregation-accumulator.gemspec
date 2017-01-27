# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'data_aggregation-accumulator'
  s.version = '0.3.0.0'
  s.summary = 'Data aggregation accumulator library'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/data-aggregation-accumulator'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'
  s.bindir = 'bin'

  s.add_runtime_dependency 'evt-entity_cache', '~> 0.6.0'

  s.add_runtime_dependency 'evt-entity_projection'
  s.add_runtime_dependency 'evt-consumer-event_store'
  s.add_runtime_dependency 'event_store-consumer-error_handler', '>= 0.3.0.0.pre1'
end
