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
                        <p>
                          All right, You just setup your blog! Now what? Well there are a couple of things you can do
                          for example, you can create a new post or start to change this amazing template!
                        </p>

                        <p>
                          Is Bluag for you? I dont know I just built this to practice playing with the Lua programming
                          language. Also I wanted to start a blog but didn't want to use the massive thing that is them 
                          crazy CMS thingies. I hope that with Bluag, as a developer you can just easisly manipulate the
                          content of your post and just over all have more fun instead of dealing with broken or confusing
                          plugins.
                        </p>

                        <h4 style="padding-top: 40px;">Recent Posts:</h4>
                        {{recent_posts}}
                      ]]
    file:write(default_content)
    file:close()
  end
end

function create_default_layout(filename)
  if file_exists(filename) then
    local file = io.open(filename, "w")
    application_layout = [[<!DOCTYPE html>
      <html>
        <head>
          <title>
            {{title}}
          </title>
          <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
          <style>
            html,body {
              height: 100%
            }

            #footer{
              bottom: -50px;
              height: 50px;
              left: 0;
              position: absolute;
              right: 0;
            }
          </style>
        </head>
        <body>
          <div class="row-fluid" style="background-color: black; padding-top: 15px;">
            <div class="span12 offset3">
              <p style="color: white">
                <strong>
                  <a href="/index.html" style="color: white;">home</a> &nbsp;|&nbsp;
                </strong> 
                <small class="muted">your lua blogging thingie</small>
              </p>
            </div>
          </div>
          <div class="row-fluid" class="span12" style="background-color: gray;">
            <div>
              <div class="row-fluid" style="background-color: #00e1ce; padding-top: 55px;">
                <div class="span3"></div>
                <div class="span6"><h1 style="color: white; font-size: 100px; text-align: right;">BLUAG!</h1></div>
                <div class="span3"></div>
              </div>
              <div class="row-fluid" style="background-color: white; padding-top: 35px;">
                <div class="span3"></div>
                <div class="span6">{{content}}</div>
                <div class="span3"></div>
              </div>
            </div>
          </div>
          <div id="footer" class="row-fluid" style="padding-top: 15px;">
          </div>
        </body>
      <html>]]
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
