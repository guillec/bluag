require "xavante.cgiluahandler"



function fwrite(fmt, ...)
  return io.write(string.format(fmt, ...))
end

function writeheader()
  io.write([[
  <html>
    <head><title>Your Blog</title></head>
    <body>
  ]])
end

function entry1(o)
  count = count + 1
  local title = o.title or 'none'
  fwrite('<li><a href="#%d">%s</a>\n', count, title)
end

function writetail()
  fwrite('</body></html>\n')
end

local inputfile = '../db.lua'
writeheader()

count=0
f = loadfile(inputfile)

entry = entry1
fwrite('<ul>\n')
f()
fwrite('</ul>\n')
writetail()

function fulldocument()

end

local file = io.open("example.html", "w")
file:write("Hellllloo")
file:close()

cgilua.htmlheader()
cgilua.put([[
<html>
<head>
  <title>Hello World</title>
</head>
<body>
  <strong>Hello World!</strong>
</body>
</html>
]])

