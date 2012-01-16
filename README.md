 CssJsTree
=======

[![Build Status](https://secure.travis-ci.org/charleseff/css_js_tree.png)](http://travis-ci.org/[YOUR_GITHUB_USERNAME]/[YOUR_PROJECT_NAME])

CssJsTree is a Rails plugin to allow automatic loading of css and/or javascript files using the same hierarchical structure as your controllers and views for better modularity and separation of concerns.

## What does it do exactly?
Say you have controller `Admin::User::CommentsController`, which has action `show` and you have the following files under your `public/stylesheets` folder:

- admin.css
- admin/user.css
- admin/user/comments.css
- admin/user/comments/show.css

CssJsTree will automatically include each of and only the files above that are present when rendering the corresponding view.  It works with your javascript files in the same way.

### more: support for partials
CssJsTree also automatically includes css and js files that correspond to partials that get rendered for each view.  It will only include each css and js once per partial.  So if you have in your view something like:

    ...
    <% 2.times do %>
      <%= render :partial '/shared/foo' %>
    <% end>
    <%= render :partial '/shared/bar' %>
    ...

And you have the following files under `public/javascripts`:

- shared/_foo.js
- shared/_bar.js

Then the `_foo.js` and `_bar.js` files will each be included once into your view.  It works the same way with your css files.

## Installation and Usage
Install the plugin:

    rails plugin install git@github.com:charleseff/css_js_tree.git

Then, in application_controller.rb add this line:

    helper CssJsTreeHelper

and add to your layout file:

    <html>
      <head>
        <%= css_tree %>
        <%= js_tree %>
      </head>
      ...
    </html>

That's it.  Now, any css files added to your `public/stylesheets` folder and js files added to your `public/javascripts` folder that follow the same hierarchical structure as your controllers, views, and partials will automatically get pulled into your view.

## Configuration
You can access the CssJsTree configuration by opening a CssJsTree.configure block inside your application.rb file like so:

    class Application < Rails::Application
    ...
      config.after_initialize do
        CssJsTree.configure do |config|
          config[:css_tree_location] = 'generated'
          config[:js_tree_location] = 'tree'
          ...
        end
      end
    end


### options

#### css_tree_location, js_tree_location
This is useful when you have css files that you want to reside outside of this structure, or when you're using Sass to generate your css files.

#### cache_prefix
Rails caching key prefix can be adjusted