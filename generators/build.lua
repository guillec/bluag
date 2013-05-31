function mkdir(dirname)
  os.execute("mkdir " .. dirname)
end

function move_assets_to_build()
  mkdir("_build/assets/")
  os.execute("cp -r _assets/* _build/assets/")
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function get_file_names(filedirectory)
  local files = io.popen("ls -tU " .. filedirectory, "r")
  if files then
    return files:read("*a")
  else
    return "failed to read"
  end
end

function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

function remove_config(body_with_config)
  local post_body = string.gsub(body_with_config, "--title:(.*)", "")
  post_body = string.gsub(post_body, "--end_config", "")
  return post_body
end

function write_post(post, file_title)
  local new_post = io.open("_build/" .. file_title, "w")
  new_post:write(post)
  new_post:close()
end

function clean_post_title(title)
  local file_name = string.gsub(title, ".html", "")
  local cleaned_name = string.gsub(file_name, "-", " ")
  return cleaned_name
end

function add_title_to_post(post_body)
  local the_title = string.match(post_body, "--title:(.*) --end_config")
  local post_body = string.gsub(post_body, "{{title}}", the_title)
  post_body = string.gsub(post_body, "--title:(.*) --end_config","")
  return post_body
end

function build_recent_posts()
  local all_posts = get_file_names("_sources")
  local file_of_recent_posts = io.open("_widgets/recent_posts.html", "w")
  local list_of_posts = ""
  for post_file in all_posts:gmatch("[^\r\n]+") do
    list_of_posts = list_of_posts .. "<li><a href='" .. post_file .. "'>" .. clean_post_title(post_file) .. "</a></li>"
  end
  list_of_posts = "<ul>" .. list_of_posts .. "</ul>"
  file_of_recent_posts:write(list_of_posts)
  file_of_recent_posts:close()
end

function add_widgets_to(content_body)
  local widgets = get_file_names("_widgets")
  for widget in widgets:gmatch("[^\r\n]+") do
    local widget_table = lines_from("_widgets/" .. widget)
    local widget_html = build_html_for(widget_table)
    content_body = string.gsub(content_body, "{{" .. string.gsub(widget, ".html", "") .. "}}", widget_html)
  end
  return content_body
end

function build_all(files_dir)
  local all_posts = get_file_names(files_dir)
  for post_file in all_posts:gmatch("[^\r\n]+") do
    local post_bodies = lines_from(files_dir .. "/" .. post_file)
    local post_body = build_html_for(post_bodies)
    add_post_body_to_layout(post_body, post_file)
  end
end

function build_html_for(content)
  local html = ""
  for k,v in pairs(content) do
    html = html .. v 
  end
  return html
end

function build_complex_html_for(content, body, processing)
  local new_post = ""
  for k,v in pairs(content) do
    local layouts_html = v
    layouts_html = add_widgets_to(layouts_html)
    new_post = new_post .. string.gsub(layouts_html, "{{post_body}}", body)
  end
  return new_post
end

function add_post_body_to_layout(body, file_title)
  local layout_structure = lines_from("_layouts/" .. file_title)
  if next(layout_structure) == nil then 
    layout_structure = lines_from("_layouts/default.html")
  end

  local new_post = build_complex_html_for(layout_structure, body, function (content) 

  end)



  --local new_post = ""
  --for k,v in pairs(layout_structure) do
  --  local layouts_html = v
  --  layouts_html = add_widgets_to(layouts_html)
  --  new_post = new_post .. string.gsub(layouts_html, "{{post_body}}", body)
  --end
  new_post = add_widgets_to(new_post)
  new_post = add_title_to_post(new_post)
  write_post(new_post, file_title)
end

function add_post_feed_to_index(post_feed)
  local layout_structures = lines_from("_pages/index.html")
  local new_post = ""
  for k,v in pairs(layout_structures) do
    local layouts_html = v
    new_post = new_post .. string.gsub(layouts_html, "{{posts}}", post_feed)
  end
  add_post_body_to_layout(new_post, "index.html")
end

function build_index_page()
  local all_posts = get_file_names("_sources")
  local post_feed = ""
  for post_file in all_posts:gmatch("[^\r\n]+") do
    local post_bodies = lines_from("_sources/" .. post_file)
    local post_body = ""
    for k,v in pairs(post_bodies) do
      local clean_body = remove_config(v)
      post_feed = post_feed .. clean_body
    end
    post_feed = post_feed .. "<hr/>"
  end
  add_post_feed_to_index(post_feed)
end


move_assets_to_build()
build_all("_sources")
build_all("_pages")
build_index_page()
build_recent_posts()
