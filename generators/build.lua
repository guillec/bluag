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

function write_post(post, file_title)
  local new_post = io.open("_build/" .. file_title, "w")
  new_post:write(post)
  new_post:close()
end

function add_post_body_to_layout(body, file_title)
  local layouts = get_file_names("_layouts")
  for layout in layouts:gmatch("[^\r\n]+") do
    layout_structures = lines_from("_layouts/" .. layout)
    new_post = ""
    for k,v in pairs(layout_structures) do
      layouts_html = v 
      new_post = new_post .. string.gsub(layouts_html, "{{content}}", body)
    end
    write_post(new_post, file_title)
  end
end

function add_widgets_to_post(post_body)
  local widgets = get_file_names("_widgets")
  for widget in widgets:gmatch("[^\r\n]+") do
    widget_table = lines_from("_widgets/" .. widget)
    widget_html = ""
    for k,v in pairs(widget_table) do
      widget_html = widget_html .. v 
    end
    post_body = string.gsub(post_body, "{{" .. string.gsub(widget, ".html", "") .. "}}", widget_html)
    return post_body
  end
end

local all_posts = get_file_names("_sources")
for post_file in all_posts:gmatch("[^\r\n]+") do
  post_bodies = lines_from("_sources/" .. post_file)
  post_body = ""
  for k,v in pairs(post_bodies) do
    post_body = post_body .. v 
  end
  post_body = add_widgets_to_post(post_body)
  add_post_body_to_layout(post_body, post_file)
end
