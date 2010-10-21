$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'active_support'

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../test/fixtures/sample_rails3_app'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
require 'rspec/rails'

require 'css_js_tree'

RSpec.configure do |config|
   config.mock_with :rspec
end
