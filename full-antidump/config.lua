Config = Config or {}


-- load lua files then nui

-- warning: do not load image file. you can added it on fxmanifest.lua

Config.AntiDump = {
    folder = '', -- after resources folder name. resources/afterresourcesfoldername/yourscriptfolder. or let empty if your script is inside resources folder and not in another one.
    scripts = {
        [0] = {name = 'config.lua'},
        [1] = {name = 'client.lua'},
        [2] = {nui = true, html = true, name = '/nui/main.html'},
        [3] = {nui = true, css = true, name = '/nui/main.css'},
        [4] = {nui = true, js = true, name = '/nui/main.js'}
    }
}