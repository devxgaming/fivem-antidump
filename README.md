# fivem-antidump client side + nui


please download dev-antidump with full-antidump-ready
<br><br>
full-antidump-ready is ready resource, you can put your code inside it and after finish change the folder name to your resource name<br>
<br>
the description is inside files, so make sure you open all file in full-antidump-ready before you store your code inside it.<br><br>
dev-antidump is only server side, can read the file and ban players
<br>


# fixed

sometime the trigger OnPlayerLoaded or player spawn send to client side but antidump was not loaded the scripts because of Ping? or bad connection. and your scripts not working on the player, so i have fix the problem by add some code on client.lua and public.lua

for example:

inside public.lua
```lua
local WaitUntilLoaded = true

-- change the event when player loaded or player spwan like your framework. i use here QBCore
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        while WaitUntilLoaded do Wait(0) end
        TriggerEvent('YourTriggerNameInsideClient.lua')
        -- or triggerServerEvent
        -- please don't use same event name on all your resource if is client side and is inside client.lua, use like: resource-name:client:OnPlayerLoaded
        -- if you use same event name, think about how many resource you have and how manytime it's will send the trigger
    end)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        CreateThread(function()
            while WaitUntilLoaded do Wait(0) end
            TriggerEvent('YourTriggerNameInsideClient.lua')
        end)
    end
end)

function LoadSuccess()
    WaitUntilLoaded = false
end

exports('LoadSuccess', LoadSuccess)
```

added this at the last line of your code in client.lua

```lua
CreateThread(function() exports['your-resource-name']:LoadSuccess() end)

```

and you ready to go.
<br><br>
Note: i didn't added this code inside full-antidump-ready you should do it manuel.

# contact with me

Discord: DevX Gaming#1255

Paypal: https://paypal.me/nxdev

# Donate

Thank you ```วชิรศักดิ์ สีหาภาค``` for your donate ❤️
