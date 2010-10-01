require 'test_helper'
require 'mocha'
include CssJsTreeHelper

class CssJsTreeHelperTest < ActionView::TestCase
  test "css_tree returns the correct value" do

    self.stubs(:action_name).returns('foo')
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case', 'test', 'foo.css')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case', 'test.css')).returns(false)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case.css')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view.css')).returns(false)

    assert_equal css_tree, '<link href="/stylesheets/generated/action_view/test_case.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/stylesheets/generated/action_view/test_case/test/foo.css" media="screen" rel="stylesheet" type="text/css" />',

  end

  test "js_tree returns the correct values" do

    self.stubs(:action_name).returns('foo')
    File.stubs(:exists?).with(File.join(Rails.root,'public','javascripts', 'generated', 'action_view', 'test_case', 'test', 'foo.js')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','javascripts', 'generated', 'action_view', 'test_case', 'test.js')).returns(false)
    File.stubs(:exists?).with(File.join(Rails.root,'public','javascripts', 'generated', 'action_view', 'test_case.js')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','javascripts', 'generated', 'action_view.js')).returns(false)

    assert_equal js_tree, '<script src="/javascripts/generated/action_view/test_case.js" type="text/javascript"></script>
<script src="/javascripts/generated/action_view/test_case/test/foo.js" type="text/javascript"></script>'

  end

end

