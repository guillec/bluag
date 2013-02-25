
function file_exists(name)
  local f=io.open(name,"w")
  if f~=nil then io.close(f) return true else return false end
end

function mkdir(dirname)
    os.execute("mkdir " .. dirname)
end

function create_index_page(filename)
  if not file_exists(filename) then
    file = io.open(filename, "w")
    file:write("<b>HELLO WORLD THIS IS YOUR NEW BLOG</b>")
    file:close()
  end
end

mkdir("_source/")
create_index_page("_source/index.html")
