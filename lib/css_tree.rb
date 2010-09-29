class CssTree
  @@config ||= {
          :css_tree_location => ''
  }

  cattr_accessor :config

  def self.configure(&block)
    yield @@config
  end
end

$LOAD_PATH <<  File.join(File.dirname(__FILE__), 'app', 'helpers')


require 'css_tree_helper'