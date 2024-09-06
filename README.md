# Fivem-antidump client side + nui


Please download the ```dev-antidump``` alongside the ```full-antidump-ready``` resource.

* full-antidump-ready is a ready-to-use resource. You can place your code inside it, and once you're done, change the folder name to your resource name.

* The description and instructions are inside the files, so make sure to open and read all the files in full-antidump-ready before adding your code.

* dev-antidump is server-side only, and it can read files and ban players.

<br>

# I recommend using these together.
https://github.com/QamarQ/nui_blocker

# Fixed

Sometimes, the ```OnPlayerLoaded[QBCore]``` trigger or player spawn event is sent to the client side, but the scripts are not loaded by the anti-dump due to factors like the framework loading the player too quickly, high ping, or a bad connection. As a result, your scripts may not work for the player. I have fixed the issue by adding some code to client.lua and public.lua.

```public.lua```
```lua
local WaitUntilLoaded = true

-- change the event when player loaded or player spwan like your framework. i use here QBCore
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        while WaitUntilLoaded do Wait(0) end
        TriggerEvent('YourTriggerNameInsideClient.lua')
        -- or triggerServerEvent
        -- please don't use same event name on all your resource, use like: resource-name:client:OnPlayerLoaded
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

Please add the following code at the last line of your code ```[client.lua]```

```lua
CreateThread(function() exports['your-resource-name']:LoadSuccess() end)

```

<br><br>
Note: I didn’t add this code inside the full-antidump-ready resource, so you will need to do it manually.


# New Issue:
If a player's network changes (for example, from Ethernet to Wi-Fi), they will stay connected to the server, but sometimes FiveM reloads all client scripts. When this happens, the player may get banned because their ID was already registered on `ResourceRequested`.
To fix this issue, you have two options:
* After checking the player, unban them.
* Change `exports['dev-antidump']:BanPlayer(src, reason)` to `DropPlayer(src, reason) in full-antidump-ready/server.lua:69.`<br>

- This issue only occurs when a player's network changes.<br>
- For my own server, I chose option 1.


# Note
A lot of people are adding multiple resources inside the `full-antidump-ready` config, such as `config1.lua`, `config2.lua`, `client.lua`, `client2.lua`. Many have contacted me on Discord, asking about errors caused by this.<br>
Please do not load multiple resources in one `full-antidump-ready` because of the following reasons:
* Your scripts may not work.
* If they do work, the client may experience timeouts and disconnect.<br>
<br>- Why does this happen?<br>Let's say you have two config files for two resources:
* When config1 is loaded, everything works fine.
* However, when `full-antidump` loads `config2`, it removes `config1` because `config2` also contains `config = {}`.

You might think, I'll just remove `config = {}` from `config2`, but there's another issue:<br>
 if `config1` and `config2` share the same key, the values will get overwritten. For example:<br>

`config1.lua`
```lua
config = {}

config.position = Vector3(0, 0, 0)
```
`config2.lua`
```lua
config.position = Vector3(0, 0, 0)
```

In this case, the `position` in `config1` will be replaced by the `position` in `config2`.


If your players are experiencing timeout disconnects, simply use a queue system to resolve the issue. Information about the queue system is available in `server.lua` in `full-antidump-ready`. Also, be sure to update `dev-antidump` for optimal performance.

# Contact with me

Discord: @devxgaming

# Donate
Paypal: https://paypal.me/nxdev

Thank you ```ว. สี``` for your donate ❤️<br>
Thank you ```M. V.D``` for your donate ❤️
