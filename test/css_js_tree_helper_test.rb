require 'test_helper'
require 'mocha'
include CssTreeHelper

class CssTreeHelperTest < ActionView::TestCase
  # Replace this with your real tests.
  test "css_tree returns the correct value" do

    self.stubs(:action_name).returns('foo')
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case', 'test', 'foo.css')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case', 'test.css')).returns(false)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view', 'test_case.css')).returns(true)
    File.stubs(:exists?).with(File.join(Rails.root,'public','stylesheets', 'generated', 'action_view.css')).returns(false)

    assert_equal css_tree, '<link href="/stylesheets/generated/action_view/test_case.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/stylesheets/generated/action_view/test_case/test/foo.css" media="screen" rel="stylesheet" type="text/css" />'

  end

end

