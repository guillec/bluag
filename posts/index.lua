require "xavante.cgiluahandler"

function fwrite(fmt)
  print(fmt)
  return fmt
end

function entry1(o)
  count = count + 1
  local title = o.title or 'none'
  fwrite('<li><a href="#%d">' .. title .. '</a>\n')
end

local inputfile = '../db.lua'


count=0
f = loadfile(inputfile)

entry = entry1

cgilua.htmlheader()
cgilua.put("<html><body>")
cgilua.put(f())
cgilua.put("</body></html>")

