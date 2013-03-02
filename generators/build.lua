function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function get_file_names(filedirectory)
  local files = io.popen("ls " .. filedirectory, "r")
  if files then
    return files:read("*a")
  else
    return "failed to read"
  end
end

function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function add_post_body_to_layout(body)
  local layouts = get_file_names("_layouts")

  for layout in layouts:gmatch("[^\r\n]+") do
    layout_structures = lines_from("_layouts/" .. layout)
    for k,v in pairs(layout_structures) do
      layouts_html = v 
      new_post = string.gsub(layouts_html, "{{body}}", body)
      print(new_post)
    end
  end
end

local all_posts = get_file_names("_sources")
for posts in all_posts:gmatch("[^\r\n]+") do
  post_bodies = lines_from("_sources/" .. posts)
  for k,v in pairs(post_bodies) do
    post_body = v 
    add_post_body_to_layout(post_body)
  end
end
