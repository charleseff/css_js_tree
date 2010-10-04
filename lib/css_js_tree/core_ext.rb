class ActionView::Partials::PartialRenderer

  # detects js and css files associated with partials and includes them in a content_for block
  def render_partial_with_css_js_tree
    @css_js_tree_request_cache ||= {}
    path = @template.virtual_path
    path_key = path.to_sym

    if not @css_js_tree_request_cache.has_key? path_key
      @css_js_tree_request_cache[path_key] = nil

      render_css_include path
      render_js_include path
    end

    render_partial_without_css_js_tree
  end

  alias_method_chain :render_partial, :css_js_tree

  private
  [:css, :js].each do |type|
    case type
      when :css
        method_name = :render_css_include
        key_prefix = 'css_tree_partial_'
        tree_location = :css_tree_location
        ext = '.css'
        path_dir = 'stylesheets'
        content_for = :css_tree
        include_tag_method = :stylesheet_link_tag
      when :js
        method_name = :render_js_include
        key_prefix = 'js_tree_partial_'
        tree_location = :js_tree_location
        ext = '.js'
        path_dir = 'javascripts'
        content_for = :js_tree
        include_tag_method = :javascript_include_tag
    end

    define_method(method_name) do |path|
      key = (key_prefix + path).to_sym

      value = Rails.cache.fetch(key) do
        rel_location = CssJsTree.config[tree_location] + @template.virtual_path + ext
       ( File.exists? File.join(Rails.root, 'public', path_dir, rel_location) ) ?  rel_location : nil
      end
      @view.content_for content_for, @view.send(include_tag_method, value) if value

    end
  end



end
