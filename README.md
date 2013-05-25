# BLUAG
Blogging platform built in Lua for developers. (Verison 1.0)

# Requirements:
1. Linux style system. No Windows sorry (Need help with this.)
2. Lua. Built and tested on Lua 5.1.5  Copyright (C) 1994-2012 Lua.org, PUC-Rio
3. Create you own github page http://pages.github.com/
4. git

# Installing:
1. Clone the repository to your system.
2. Run the following command to set your file structure: 
  - lua generators/newblog.lua
  - Check out the file structure that was built (more about the
    structure bellow).
3. Run the following to build the default blog:
  - lua generators/build.lua
4. Make your _build directory the 'master' branch to your github pages project.
5. Push your content inside your _build directory to your github pages.

# Build:
Once you have edited your code or created a new page just run:
  - lua generators/build.lua
  - This will run the build script and add the edited content to the
    _build directory.
  - You can view you content by either pushing to github pages or
    navigating to directory.

# File Structure:
1. _assets/
  - This holds your stylesheets and images.
  - On build, all folders and files in this directory get copied to _build/assets

2. _build/
  - On build, this directory gets populated with your blog.
  - This is the directory you need to push to your github page

3. _layouts/
  - Holds all layouts for your blog
  - On build, all pages and posts will use this layout unless specified to use another
  - If you want a page to use a different layout name the layout with the same name as the page.
    For example, if you add a about.html page to the _pages directory and you want to use a different layout for that page, create
    a about.html layout in the _layouts directory.

4. _pages/
  - Add all and any new page to this directory
  - ALL PAGES REQUIRE A --title block

5. _sources/
  - Put your blog posts in here
  - ALL POSTS REQUIRE A --title block

6. _widgets/
  - A widget can be any small amount of html that you want
  - Add any widget that you want here
  - To use widgets just place {{widget_file_name}} anywhere in a page, blog post or layout.
    For example, if you want to use the recent_posts.html widget on a page place {{recent_posts}} somewhere on the source.
  - On build, all pages, layouts and posts will be tested for {{widget_name}} and appended if they exist.

# Other Notes:
1. For the most part Bluag is using twitter bootstrap for styling.

# Contributing:
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request



