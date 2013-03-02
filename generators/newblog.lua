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
    application_layout = [[
      <!DOCTYPE html>`
      <html>
        <head>
          <title>
            {{title}}
          </title>
        </head>
        <body>
          {{body}}
        </body>
      <html>
    ]]
    file:write(application_layout)
    file:close()
  end
end

mkdir("_sources/")
mkdir("_layouts/")
mkdir("_build/")
create_index_page("_sources/index.html")
create_default_layout("_layouts/default.html")
