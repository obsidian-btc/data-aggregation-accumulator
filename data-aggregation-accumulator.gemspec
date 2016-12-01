# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'data_aggregation-accumulator'
  s.version = '0.0.0.1'
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

  s.add_runtime_dependency 'entity_cache'
  s.add_runtime_dependency 'event_store-entity_projection'
  s.add_runtime_dependency 'event_store-consumer'

  s.add_development_dependency 'fixtures-expect_message'
end
