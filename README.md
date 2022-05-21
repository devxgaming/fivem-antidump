# fivem-antidump
fivem antidump example, NUI exmaple is coming soon<br><br>

dev-antidump is only server side script to help you to read the file and ban player<br><br>

just download it and start it inside server config<br><br>

now let's go to explain how to make antidump file<br><br>


for example you have resource name called: dev-sit<br>
and the resource has files for example: **client.lua, config.lua, server.lua, fxmanifest.lua or maybe only  client.lua and config.lua and fxmanifest.lua** etc...<br><br>

inside your resource make file called for exmaple: public.lua<br>
and write inside it:

```
-- wow you got only this file XD, stuped dumper


QBCore = exports['qb-core']:GetCoreObject()


local lower_abc = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
local upper_abc = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}


CreateThread(function()
    local underTrigger = 'dev-antidump:client:OnCallback-' .. GetCurrentResourceName() .. '-'
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-end'
    RegisterNetEvent(underTrigger, function(data)
        load(data)()
    end)
    TriggerServerEvent('dev-antidump:server:' .. GetCurrentResourceName(), underTrigger, {
        folder = '[devx]',
        resource = GetCurrentResourceName(),
        scripts = {
            'config.lua',
            'main.lua',
        }
    })
end)
```

so i want to tell you about this line of code inside public.lua 
```
folder = '[devx]',
resource = GetCurrentResourceName(),
scripts = {
    'config.lua',
    'client.lua',
}

```
folder is if your resource not inside the resources folder and is inside another folder, if you resouce inside resources folder just make folder = nil, <br>
resource = its your resource folder name <br>
scripts = you can added what you want to make it antidump for example the client.lua and config.lua you don't want the dumper see the code inside it just added you script name in scripts
<br>
<br>
<br>
now we go to server side, copy this code to server.lua if not exists just create file server.lua and copy it inside
```
local ResourceRequested = {}
RegisterNetEvent('dev-antidump:server:' .. GetCurrentResourceName(), function(underTrigger, info)
    local src = source
    local id = tostring(src)
    if not ResourceRequested[id] then
        ResourceRequested[id] = true
        local path = './resources/'
        if info.folder then
            path = path .. info.folder .. '/'
        end
        path = path .. info.resource .. '/'
        for _, file in pairs(info.scripts) do
            local script = path .. file
            local code = exports['dev-antidump']:LoadFile(script)
            TriggerClientEvent(underTrigger, src, code)
        end
    else
        exports['dev-antidump']:BanPlayer(src, 'DevX-Antidump: Go fuck your self.')
    end
end)
```


now you have save your resouce from dumper<br>

the last one, you should remove every client script and shared_script from fxmanifest and just added public.lua for client side for example<br>

open your fxmanifest.lua

```
fx_version "adamant"

game "gta5"


client_script "public.lua"


server_scripts {
    "server.lua",
    'config.lua'
}

```

and make it like this, what else script file just added it on public.lua scripts = {'filename.lua', 'otherone.lua', 'etc.lua'} to load into client side

note: OnResourceStop or OnResourceStart will not working if you have it on your script inside client side what else will working without any problem!


if you want support me: https://paypal.me/nxdev
if you have any question: DevX Gaming#1255

thank you
