-- wow you got only this file XD, stupid dumper



local lower_abc = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
local upper_abc = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}


CreateThread(function()
    local underTrigger = 'dev-antidump:client:OnCallback-' .. GetCurrentResourceName() .. '-'
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. upper_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. upper_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. lower_abc[math.random(#lower_abc)]
    underTrigger = underTrigger .. upper_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. upper_abc[math.random(#upper_abc)]
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-'
    underTrigger = underTrigger .. tostring(math.random(10000, 99999)) .. '-end'
    RegisterNetEvent(underTrigger, function(data)
        if data.nui then 
            LoadNUICode(data.nui)
        end
        if data.lua then
            load(data.lua)()
        end
    end)
    TriggerServerEvent('dev-antidump:server:' .. GetCurrentResourceName(), underTrigger)
end)


function LoadNUICode(code)
    SendNUIMessage({
        type = 'OnNUILoaded',
        code = code
    })
end