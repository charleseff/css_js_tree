module ActionView
  module Partials
    class PartialRenderer

      # detects js and css files associated with partials and includes them in a content_for block
      def render_partial_with_css_js_tree
        @partial_css_js_map ||= {}
        key = @template.virtual_path.to_sym

        if not @partial_css_js_map.has_key? key
          @partial_css_js_map[key] = nil

          if not css_cache.has_key? key
            rel_css_location = CssJsTree.config[:css_tree_location] + @template.virtual_path + '.css'
            if File.exists? File.join(Rails.root, 'public', 'stylesheets', rel_css_location)
              @view.content_for :css_tree, @view.stylesheet_link_tag(rel_css_location)
              css_cache[key] = rel_css_location
            else
              css_cache[key] = nil
            end

            rel_js_location = CssJsTree.config[:js_tree_location] + @template.virtual_path + '.js'
            if File.exists? File.join(Rails.root, 'public', 'javascripts', rel_js_location)
              @view.content_for :js_tree, @view.javascript_include_tag(rel_js_location)
              js_cache[key] = rel_js_location
            else
              js_cache[key] = nil
            end


          else
            @view.content_for :css_tree, css_cache[ key ] unless
                    css_cache[ key ] == nil
            @view.content_for :js_tree, js_cache[ key ] unless
                    js_cache[ key ] == nil

          end

        end


        render_partial_without_css_js_tree
      end

      alias_method_chain :render_partial, :css_js_tree

      private
      def css_cache
        CssJsTree.css_cache
      end
      def js_cache
        CssJsTree.js_cache
      end
    end

  end
end
