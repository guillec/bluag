-------------------------------------------------------------------------------
-- Sample Xavante configuration file for launching WSAPI applications.
------------------------------------------------------------------------------

require "xavante"
require "xavante.filehandler"
require "xavante.cgiluahandler"
require "wsapi.xavante"

-- Define here where Xavante HTTP documents scripts are located
local webDir = "posts/"

local simplerules = {

 { -- URI remapping example
 match = "^[^%./]*/$",
 with = xavante.redirecthandler,
 params = {"index.html"}
 },

 { -- cgiluahandler example
 match = {"%.lp$", "%.lp/.*$", "%.lua$", "%.lua/.*$" },
 with = xavante.cgiluahandler.makeHandler (webDir)
 },


 { -- filehandler example
 match = ".",
 with = xavante.filehandler,
 params = {baseDir = webDir}
 },
} 

-- Displays a message in the console with the used ports
xavante.start_message(function (ports)
 local date = os.date("[%Y-%m-%d %H:%M:%S]")
 print(string.format("%s Xavante started on port(s) %s",
 date, table.concat(ports, ", ")))
 end)

xavante.HTTP{
 server = {host = "*", port = 8080},
 
 defaultHost = {
 rules = simplerules
 },
}

xavante.start()
