Config = Config or {}

-- folder is: script folder name, for example: if your resource not inside resources folder then added the folder that your script inside it, for example like this path:
-- resources/custom/yourscript/files. .. . .
-- you should make folder = 'custom' if is more then folder make it: folder = 'custom/otherone/'
-- if your script folder is inside resource direct then make folder = ''
-- so i have resouce name dev-gas and it inside folder [devx]


-- scripts: that's mean you load the script in local memory of lua or js language
-- so you should whiche script you want to make it antidump
-- for example i have html files like: html, css, js and i have lua: config.lua, client.lua
-- if your resource has config.lua you should added it at first on scripts
-- don't added images to scripts

Config.AntiDump = {
    folder = '[devx]', 
    scripts = {
        [0] = {name = 'config.lua'},
        [1] = {name = 'client.lua'},
        [2] = {nui = true, html = true, name = '/html/main.html'},
        [3] = {nui = true, css = true, name = '/html/style.css'},
        [4] = {nui = true, js = true, name = '/html/main.js'}
    }
}

-- continue your config code here.. note: config also can't be dumped ;-)
