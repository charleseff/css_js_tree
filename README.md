 CssTree
=======
CssTree is a Rails plugin to allow automatic loading of css files using the same hierarchical structure as your controllers and views for better modularity and separation of concerns.

## What does it do exactly?
Say you have controller `Admin::User::CommentsController`, which has action `show` and you have the following files under your `public/stylesheets` folder:

- admin.css
- admin/user.css
- admin/user/comments.css
- admin/user/comments/show.css

CssTree will automatically include each of and only the files above that are present.

## Installation
Install the plugin:

    rails plugin install git@github.com:cmanfu/css_tree.git

Then, in application_controller.rb add this line:

    helper CssTreeHelper

and add to your layout file:

    <html>
      <head>
        <%= css_tree %>
      </head>
      ...
    </html>

That's it.  Now, any css files added to your `public/stylesheets` folder that follow the same hierarchical structure as your controllers and views will automatically get pulled into your view.

## Configuration
To change the default root directory to something other than `public/stylesheets`, you can set a relative directory like this (in your application.rb file):

    class Application < Rails::Application
    ...
      config.after_initialize do
        CssTree.configure do |config|
          config[:css_tree_location] = 'generated'
        end
      end
    end

This is useful when you have css files that you want to reside outside of this structure, or when you're using Sass to generate your css files.