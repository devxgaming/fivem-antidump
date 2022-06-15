local ResourceRequested = {}

RegisterNetEvent('dev-antidump:server:' .. GetCurrentResourceName(), function(underTrigger)
    local src = source
    local id = tostring(src)
    if not ResourceRequested[id] then
        ResourceRequested[id] = true
        local info = Config.AntiDump
        local path = './resources/'
        if info.folder then
            path = path .. info.folder .. '/'
        end
        path = path .. GetCurrentResourceName() .. '/'

        local NUICode = ''
        local ResCode = ''

        for _, file in pairs(info.scripts) do
            local script = path .. file.name
            if file.nui then
                if file.html then
                    NUICode = NUICode .. exports['dev-antidump']:LoadFile(script)
                end

                if file.js then
                    NUICode = NUICode .. '<script>' .. exports['dev-antidump']:LoadFile(script) .. '</script>'
                end

                if file.css then
                    NUICode = NUICode .. '<style>' .. exports['dev-antidump']:LoadFile(script) .. '</style>'
                end
            else
                ResCode = ResCode .. exports['dev-antidump']:LoadFile(script)
            end
        end

        local data = {
            nui = NUICode,
            lua = ResCode
        }
        TriggerClientEvent(underTrigger, src, data)
    else
        exports['dev-antidump']:BanPlayer(src, 'DevX-Antidump: Go fuck your self.')
    end
end)


-- Here you go, continue your code in server side what you want to do??


