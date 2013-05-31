function get_file_names(filedirectory)
  local files = io.popen("ls -tU " .. filedirectory, "r")
  if files then
    return files:read("*a")
  else
    return "failed to read"
  end
end

function build_sitemap(filename, title)
  local file_path = "_build/sitemap.xml"
  local file      = io.open(file_path, "w")

  local all_posts = get_file_names("_sources")
  local loc = ""
  for post_file in all_posts:gmatch("[^\r\n]+") do
    local loc = "<loc>" .. post_file .. "</loc>"
  end
  list_of_posts = "<ul>" .. list_of_posts .. "</ul>"
  file_of_recent_posts:write(list_of_posts)
  file_of_recent_posts:close()



  default_content = [[
    --title: ]] .. title .. [[
    
    --end_config

    <p>
      Add countent to your page here
    </p>

  ]]
  file:write(default_content)
  file:close()
end

build_sitemap()
