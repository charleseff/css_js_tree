module CssTreeHelper
  def css_tree

    hierarchy = controller.class.to_s.underscore.gsub('_controller','').split('/') + [action_name]

    included_css = 1.upto(hierarchy.size).inject([])  do |array, i |
      rel_location = CssTree.config[:css_tree_location] + '/' + hierarchy[0,i].join('/') + '.css'
      array << rel_location if File.exists? File.join(Rails.root, 'public', 'stylesheets', rel_location )
      array
    end

    included_css.empty? ? '' : stylesheet_link_tag(included_css)
  end

end