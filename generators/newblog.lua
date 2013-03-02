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
    file:write("<b>Your Bluag Blog</b>")
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
        </head>
        <body>
          <div class="row-fluid">
            <div class="span12" style="background-color: black;text-align: center;">
              <h1 style="color: white">BLUAG</h1>
              <div class="row-fluid" style="background-color: white;">
                <div class="span3"></div>
                <div class="span6">{{content}}</div>
                <div class="span3"></div>
              </div>
            </div>
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
                          <ul class="recent-posts-list">
                          <li><a href='/index.html'>Your Bluag Blog</a></li>
                          </ul>
                         ]]
    file:write(list_recent_posts)
    file:close()
  end
end

mkdir("_sources/")
mkdir("_layouts/")
mkdir("_build/")
mkdir("_widgets/")
create_index_page("_sources/index.html")
create_default_layout("_layouts/default.html")
create_recent_posts("_widgets/recent_posts.html")
