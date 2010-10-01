module ActionView
  module Partials
    class PartialRenderer
      include ActionView::Helpers::AssetTagHelper

      # detects js and css files associated with partials and includes them in a content_for block
      def render_partial_with_css_js_tree
        @partial_css_js_map ||= {}

        if not @partial_css_js_map.has_key? @template.virtual_path.to_sym
          @partial_css_js_map[@template.virtual_path.to_sym] = nil

          rel_css_location = CssJsTree.config[ :css_tree_location ] + @template.virtual_path + '.css'
          if File.exists? File.join(Rails.root, 'public', 'stylesheets', rel_css_location)
            @view.content_for :css_tree, @view.stylesheet_link_tag(rel_css_location)
          end

          rel_js_location = CssJsTree.config[ :js_tree_location ] + @template.virtual_path + '.js'
          if File.exists? File.join(Rails.root, 'public', 'javascripts', rel_js_location)
            @view.content_for :js_tree, @view.javascript_include_tag(rel_js_location)
          end
        end


        render_partial_without_css_js_tree
      end

      alias_method_chain :render_partial, :css_js_tree

    end

  end
end
