local QBCore = exports['qb-core']:GetCoreObject()

function BanPlayer(src, reason)
    local banTime = 2147483647
    local timeTable = os.date('*t', banTime)
    TriggerClientEvent('chat:addMessage', -1, {
        template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
        args = {GetPlayerName(src), reason}
    })
    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        QBCore.Functions.GetIdentifier(src, 'license'),
        QBCore.Functions.GetIdentifier(src, 'discord'),
        QBCore.Functions.GetIdentifier(src, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    DropPlayer(src, 'You has been banned from server reason:\n'.. reason ..'\n for more information join discord: https://discord.gg/FbVmdspcCP')
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(src), "DevX-Antidump", reason), true)
end

function isFileExists(path)
    local file = io.open(path, 'r')
    if file ~= nil then io.close(file) return true else return false end
end

function LoadFile(path)
    if not isFileExists(path) then
        print('error: dev-antidump, can not find file on path: '.. path)
        return
    end
    local file = io.open(path, 'r')
    local content = file:read('*a')
    io.close(file)
    return content
end



exports('LoadFile', LoadFile)
exports('BanPlayer', BanPlayer)

