class ActionView::Partials::PartialRenderer

  # detects js and css files associated with partials and includes them in a content_for block
  def render_partial_with_css_js_tree
    @css_js_tree_request_cache ||= {}
    path = @template.virtual_path
    path_key = path.to_sym

    if not @css_js_tree_request_cache.has_key? path_key
      @css_js_tree_request_cache[path_key] = nil

      css_key = ('css_tree_partial_' + path).to_sym
      js_key = ('js_tree_partial_' + path).to_sym

      if not Rails.cache.exist?(css_key)
        rel_css_location = CssJsTree.config[:css_tree_location] + @template.virtual_path + '.css'
        if File.exists? File.join(Rails.root, 'public', 'stylesheets', rel_css_location)
          @view.content_for :css_tree, @view.stylesheet_link_tag(rel_css_location)
          Rails.cache.write(css_key, rel_css_location)
        else
          Rails.cache.write(css_key, nil)
        end

        rel_js_location = CssJsTree.config[:js_tree_location] + @template.virtual_path + '.js'
        if File.exists? File.join(Rails.root, 'public', 'javascripts', rel_js_location)
          @view.content_for :js_tree, @view.javascript_include_tag(rel_js_location)
          Rails.cache.write(js_key, rel_js_location)
        else
          Rails.cache.write(js_key, nil)
        end

      else
        @view.content_for :css_tree, Rails.cache.read(css_key) if Rails.cache.read(css_key)
        @view.content_for :js_tree, Rails.cache.read(js_key) if Rails.cache.read(js_key)
      end

    end


    render_partial_without_css_js_tree
  end

  alias_method_chain :render_partial, :css_js_tree

end
