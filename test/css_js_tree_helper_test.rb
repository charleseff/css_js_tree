require 'test_helper'
require 'mocha'
include CssJsTreeHelper

class CssJsTreeHelperTest < ActionView::TestCase

  def setup
    Rails.cache.clear
    self.stubs(:action_name).returns('foo')
    self.stubs(:content_for).returns( ActiveSupport::SafeBuffer.new)
  end

  test "css_tree returns the correct value" do
    File.stubs(:exists?).returns(false)
    File.expects(:exists?).with(File.join(Rails.root,'public','stylesheets', 'action_view.css')).returns(true)
    File.expects(:exists?).with(File.join(Rails.root,'public','stylesheets', 'action_view', 'test_case', 'test', 'foo.css')).returns(true)

    assert_equal css_tree, '<link href="/stylesheets/action_view.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/stylesheets/action_view/test_case/test/foo.css" media="screen" rel="stylesheet" type="text/css" />'

  end

  test "js_tree returns the correct values" do
    File.stubs(:exists?).returns(false)
    File.expects(:exists?).with(File.join(Rails.root,'public','javascripts', 'action_view.js')).returns(true)
    File.expects(:exists?).with(File.join(Rails.root,'public','javascripts', 'action_view', 'test_case', 'test', 'foo.js')).returns(true)

    assert_equal js_tree, '<script src="/javascripts/action_view.js" type="text/javascript"></script>
<script src="/javascripts/action_view/test_case/test/foo.js" type="text/javascript"></script>'

  end

  test 'partial css and js get pulled in' do
    File.stubs(:exists?).returns(false)
    File.expects(:exists?).times(1).with(File.join(Rails.root,'public','stylesheets', '_test.css')).returns(true)
    File.expects(:exists?).times(1).with(File.join(Rails.root,'public','javascripts', '_test.js')).returns(true)

    render :partial => 'test'
    render :partial => 'test'

    assert_equal css_tree, '<link href="/stylesheets/_test.css" media="screen" rel="stylesheet" type="text/css" />'
    assert_equal js_tree, '<script src="/javascripts/_test.js" type="text/javascript"></script>'
  end

end

