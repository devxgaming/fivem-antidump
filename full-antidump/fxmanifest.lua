resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

fx_version 'bodacious'

game 'gta5'

description 'your resource description'


version '1.0.0'


client_script 'client/public.lua'

server_scripts {
    'config.lua',
	'server.lua',
}

-- your script has nui?? if not comment from here to top of lua54 'yes'
ui_page "nui/antidump.html"

files {
	'nui/antidump.html',
    'nui/antidump.js'
	-- 'nui/images/*.png' -- your nui has image?? 
}

lua54 'yes'
