function mkdir(dirname)
  if not file_exists(dirname) then
    os.execute("mkdir " .. dirname)
  end
end

function file_exists(name)
  local f=io.open(name,"w")
  if f~=nil then io.close(f) return true else return false end
end

function create_index_page(filename)
  local file = io.open(filename, "w")
  file:write("<b>HELLO WORLD THIS IS YOUR NEW BLOG</b>")
  file:close()
end

mkdir("_source")
create_index_page("index.html")
