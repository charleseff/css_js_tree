class CssJsTree

  @@config ||= {
          :css_tree_location => '',
          :js_tree_location => ''
  }

  cattr_accessor :config

  def self.configure(&block)
    yield @@config
  end


end

require "css_js_tree/core_ext"

$LOAD_PATH <<  File.join(File.dirname(__FILE__), 'app', 'helpers')
require 'css_js_tree_helper'
