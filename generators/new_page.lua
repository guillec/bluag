function new_post(filename, title)
  local file_path = "_pages/" .. filename .. ".html"
  local file      = io.open(file_path, "w")
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

local title    = table.concat(arg, " ")
local filename = string.gsub(title, " ", "-")
new_post(filename, title)
