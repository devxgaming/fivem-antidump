-- wow you got only this file XD, stupid dumper

local lower_abc = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
local upper_abc = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

local function getLowerCase()
    return lower_abc[math.random(#lower_abc)]
end

local function getUpperCase()
    return upper_abc[math.random(#upper_abc)]
end

local function getNumber()
    return tostring(math.random(10000, 99999)) .. "-"
end

local function generateNameChunk()
    return getLowerCase() ..
        getLowerCase() ..
            getUpperCase() ..
                getUpperCase() .. getNumber() .. getNumber() .. getNumber()
end

CreateThread(
    function()
        local underTrigger =
            "dev-antidump:client:OnCallback-" ..
            GetCurrentResourceName() ..
                generateNameChunk() .. generateNameChunk() .. "end"

        RegisterNetEvent(
            underTrigger,
            function(data)
                if data.nui then
                    loadNui = {}
                    if data.html then
                        loadNui.html = data.html
                    end
                    if data.css then
                        loadNui.css = data.css
                    end

                    if data.js then
                        loadNui.js = data.js
                    end

                    LoadNUICode(loadNui)
                end

                if data.lua then
                    load(data.lua)()
                end
            end
        )

        TriggerServerEvent(
            "dev-antidump:server:" .. GetCurrentResourceName(),
            underTrigger
        )
    end
)

function LoadNUICode(code)
    Wait(2000)

    SendNUIMessage(
        {
            type = "OnNUILoaded",
            code = code
        }
    )
end
