require 'spec_helper'

describe CssJsTreeHelper do

  before(:each) do
    Rails.cache.clear
    self.stubs(:action_name).returns('foo')
    self.stubs(:content_for).returns( ActiveSupport::SafeBuffer.new)
    File.stubs(:exists?).returns(false)

  end

  describe '#css_tree' do
    it 'should return the correct value' do
      File.expects(:exists?).with(File.join(Rails.root,'public','stylesheets', 'action_view.css')).returns(true)
      File.expects(:exists?).with(File.join(Rails.root,'public','stylesheets', 'action_view', 'test_case', 'test', 'foo.css')).returns(true)

      css_tree.should == '<link href="/stylesheets/action_view.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/stylesheets/action_view/test_case/test/foo.css" media="screen" rel="stylesheet" type="text/css" />'

    end

    it 'should cache prefix config change' do
      File.expects(:exists?).with(File.join(Rails.root,'public','stylesheets', 'action_view.css')).returns(true)
      css_tree
      Rails.cache.exist?("css_js_tree_css_action_view/test_case/test/foo").should be_true
      Rails.cache.clear
      Rails.cache.exist?("css_js_tree_css_action_view/test_case/test/foo").should_not be_true

      CssJsTree.config[:cache_prefix] = 'foo_'
      css_tree
      Rails.cache.exist?("foo_css_action_view/test_case/test/foo").should be_true
    end

  end

  describe '#js_tree' do
    it 'should return the correct values' do
      File.expects(:exists?).with(File.join(Rails.root,'public','javascripts', 'action_view.js')).returns(true)
      File.expects(:exists?).with(File.join(Rails.root,'public','javascripts', 'action_view', 'test_case', 'test', 'foo.js')).returns(true)

      js_tree.should == '<script src="/javascripts/action_view.js" type="text/javascript"></script>
<script src="/javascripts/action_view/test_case/test/foo.js" type="text/javascript"></script>'
    end
  end

  it 'should pull in partial css and js' do
    File.expects(:exists?).times(1).with(File.join(Rails.root,'public','stylesheets', '_test.css')).returns(true)
    File.expects(:exists?).times(1).with(File.join(Rails.root,'public','javascripts', '_test.js')).returns(true)

    render :partial => '/test'
    render :partial => '/test'

    css_tree.should == '<link href="/stylesheets/_test.css" media="screen" rel="stylesheet" type="text/css" />'
    js_tree.should == '<script src="/javascripts/_test.js" type="text/javascript"></script>'

  end


end
