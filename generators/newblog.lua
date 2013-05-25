function file_exists(name)
  local f=io.open(name,"w")
  if f~=nil then io.close(f) return true else return false end
end

function directory_exists(path)
end

function mkdir(dirname)
  if not directory_exists(dirname) then
    os.execute("mkdir " .. dirname)
  end
end

function create_index_page(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    default_content = [[
      --title: Your First Page
      --end_config
      <p>
        All right, You just setup your blog! Now what? Well there are a couple of things you can do
        for example, you can create a new post or start to change this amazing template!
      </p>

      <p>
        Is Bluag for you? I dont know, I just wanted to start a blog but didn't want to use the massive thing that is them 
        crazy CMS thingies. I hope that with Bluag, as a developer you can just easisly manipulate the
        content of your post and just over all have more fun instead of dealing with broken or confusing
        plugins.
      </p>

      {{posts}}
    ]]
    file:write(default_content)
    file:close()
  end
end

function create_default_layout(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    application_layout = [[
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>
              {{title}}
            </title>
            <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap-responsive.css" rel="stylesheet">
            <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
            {{stylesheets}}
          </head>
          <body>
            <div class="row-fluid" style="background-color: white; padding: 20px;">
              <span class="row">
                <span class="offset1">
                  <img src="http://www.pairprogramwith.me/badge.png" alt="pair with me logo" />
                </span>
                {{top_menu}}
              </span>
            </div>
            <div class="row-fluid" style="padding-top: 35px;">
              <div class="span10 offset1">{{post_body}}</div>
            </div>
            <div id="footer" class="row-fluid" style="padding-top: 15px;">
            </div>
            <script>
            <!-- Google Analytics Here -->
            </script>
          </body>
        </html>
      ]]
    file:write(application_layout)
    file:close()
  end
end

function create_recent_posts(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    list_recent_posts = [[
      <ul class="unstyled" style="padding-top: 10px;">
        <li style="border-bottom: solid 1px #999999; padding: 7px 0px;">
          <a href='/index.html'>Your Bluag Blog</a>
          <span style="float: right;" class="muted"><small>11/11/1111</small></span>
        </li>
      </ul>
     ]]
    file:write(list_recent_posts)
    file:close()
  end
end

function create_top_menu(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    list_recent_posts = [[
      <span class="offset3" style="font-size: 20px; word-spacing: 5px;">
        <a href="/index.html" rel="index" rel="index">HOME</a>
         | 
        <a href="#" rel="index" rel="about">ABOUT ME</a>
         | 
        <a href="#" rel="projects">PROJECTS</a>
      </span>
     ]]
    file:write(list_recent_posts)
    file:close()
  end
end

function create_stylesheet(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    list_recent_posts = [[
      html,body {
        height: 100%;
        background-color: #f2f2f2;
      }

      #footer{
        bottom: -50px;
        height: 50px;
        left: 0;
        position: absolute;
        right: 0;
      }

      hr {
        margin-top: 50px;
        margin-bottom: 50px;
        height: 1px;
        border: 0; border-top: 1px solid #ccc
      }

      span.label {
        margin-top: 10px;
        margin-right: 15px;
        padding: 15px;
        float: left;
      }

      div.post-header {
        margin-top: 15px;
        margin-bottom: 30px;
      }
     ]]
    file:write(list_recent_posts)
    file:close()
  end
end

function create_stylesheet_widget(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    list_recent_posts = [[
      <link rel="stylesheet" href="assets/stylesheets/style.css">
     ]]
    file:write(list_recent_posts)
    file:close()
  end
end

function create_first_post(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    list_recent_posts = [[
      --title: Your First Blog Post
      --end_config

      <br/>
      <h3>Your First Post</h3>
      <p>This file is found in the <em>_sources</em> directory. If you want to add a new blog post just create a new html file in the <em>_sources</em> directory.</p>
      <p>
        <strong>VERY IMPORTANT:</strong> every file in the <em>_sources</em> directory <strong>requires</strong> a title config block. 
        Look at the source file as an example. Without this the build will break.
       </p>
     ]]
    file:write(list_recent_posts)
    file:close()
  end
end

mkdir("_sources/")
mkdir("_pages/")
mkdir("_layouts/")
mkdir("_build/")
mkdir("_widgets/")
mkdir("_assets/")
mkdir("_assets/stylesheets/")
mkdir("_assets/images/")
create_index_page("_pages/index.html")
create_default_layout("_layouts/default.html")
create_recent_posts("_widgets/recent_posts.html")
create_top_menu("_widgets/top_menu.html")
create_stylesheet("_assets/stylesheets/style.css")
create_stylesheet_widget("_widgets/stylesheets.html")
create_first_post("_sources/the_very_first_post.html")
