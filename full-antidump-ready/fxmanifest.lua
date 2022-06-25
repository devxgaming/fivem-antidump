fx_version "cerulean"
game "gta5"
lua54 "yes"

author "https://github.com/omar-othmann"
description "Anti dump boilerplate"
version "1.0.0"

-- add only public.lua for client side!!
client_script "public.lua"

-- add what you want to server side, can't be dumped!, don't forget config.lua
server_scripts {
  "config.lua",
  "server.lua"
}

-- so you have nui?? add only /html/antidump.html to ui_page
ui_page "html/antidump.html"

-- added antidump.html and antidump.js, you have images? added it
files {
  "html/antidump.html",
  "html/antidump.js",
  "html/images/*.png",
  "html/images/*.jpg",
  "html/images/*.jpeg"
}
