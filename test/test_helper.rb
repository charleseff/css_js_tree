require 'rubygems'
require 'test/unit'
require 'active_support'

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/fixtures/sample_rails3_app'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
require File.join( File.dirname(__FILE__), '..', 'lib', 'css_js_tree' )