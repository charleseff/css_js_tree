module CssJsTreeHelper

  [:css,:js].each do |type|
    case type
      when :css
        method_name = :css_tree
        cache_prefix = 'css_'
        tree_location = :css_tree_location
        folder = 'stylesheets'
        include_tag_method = :stylesheet_link_tag
        content_for_sym = :css_tree
        ext = '.css'
      when :js
        method_name = :js_tree
        cache_prefix = 'js_'
        tree_location = :js_tree_location
        folder = 'javascripts'
        include_tag_method = :javascript_include_tag
        content_for_sym = :js_tree
        ext = '.js'
    end

    define_method(method_name) do
      path = controller.class.to_s.underscore.gsub('_controller', '') + '/' + action_name

      key = (CssJsTree.config[:cache_prefix] + cache_prefix + path).to_sym
      Rails.cache.fetch(key) do
        hierarchy = path.split('/')

        included = 1.upto(hierarchy.size).inject([]) do |array, i|
          rel_location = ((CssJsTree.config[tree_location] == '') ? '' : CssJsTree.config[tree_location] + '/') +
                  hierarchy[0, i].join('/') + ext
                  array << rel_location if File.exists? File.join(Rails.root, 'public', folder, rel_location)
          array
        end

        ret_val = ActiveSupport::SafeBuffer.new
        ret_val += self.send(include_tag_method, included) unless included.empty?
        ret_val += (@view || self).content_for(content_for_sym)

        Rails.cache.write(key, ret_val)
        ret_val
      end

    end

  end
end