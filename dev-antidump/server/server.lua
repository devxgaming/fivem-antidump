local QBCore = exports["qb-core"]:GetCoreObject()

-- (Optional) Notify the server about the ban
local function _notifyAboutBan(src, reason)
    -- You can replace below event with your own message
    TriggerClientEvent(
        "chat:addMessage",
        -1,
        {
            template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
            args = {GetPlayerName(src), reason}
        }
    )
end

-- Ban the player
local function _banPlayer(src, reason)
    -- Applying ban to the database
    -- You don't have to do that and use your own banning system
    MySQL.ready(
        function()
            MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
            {
                GetPlayerName(src),
                QBCore.Functions.GetIdentifier(src, 'license'),
                QBCore.Functions.GetIdentifier(src, 'discord'),
                QBCore.Functions.GetIdentifier(src, 'ip'),
                reason,
                2147483647,
                'DevX-Antidump'
            })
        end
    )

    -- The actual ban function
    -- You can change the translations in `server_config.lua` file or replace it altogether with your own implementation
end

local function doesFileExist(path)
    local file = io.open(path, "r")

    if file ~= nil then
        io.close(file)

        return true
    else
        return false
    end
end

function BanPlayer(src, reason)
    -- ban the player
    _banPlayer(src, reason)

    -- optionally notify about the ban
    _notifyAboutBan(src, reason)

    TriggerEvent(
        "qb-log:server:CreateLog",
        "bans",
        "Player Banned",
        "red",
        string.format(
            "%s was banned by %s for %s",
            GetPlayerName(src),
            "DevX-Antidump",
            reason
        ),
        true
    )
    DropPlayer(
        src,
        ("You have been banned from the server. Reason: %s. For more information join discord: https://discord.gg/XXXXXXXX"):format(
            reason
        )
    )
end

function KickPlayer(src, reason)
    Drop(src, reason)
end

RegisterNetEvent('dev-antidump:server:ScriptLoaded', function(name)
    local src = source
    local id = tostring(src)
    if not ResourcesQueue[id] then return BanPlayer(src, 'Go fuck your self.') end
    if not ResourcesQueue[id].resources[name] then return BanPlayer(src, 'Go fuck your self') end
    if ResourcesQueue[id].loadedRes == name then
        ResourcesQueue[id].isLoading = false
        ResourcesQueue[id].resources[name].loaded = true
        Wait(1000)
        if not ResourcesQueue[id].isLoading then
            local find = FindWhereNotLoadedResources(id)
            if find then
                TriggerClientEvent(find.under, find.src, find.code)
                ResourcesQueue[id].isLoading = true
                ResourcesQueue[id].loadedRes = find.name
            end
        end
    end
end)


function FindWhereNotLoadedResources(id)
    for _, info in pairs(ResourcesQueue[id].resources) do
        if not info.loaded then return info end
    end
    return nil
end

function InsertQueue(src, underTrigger, code, name)
    local id = tostring(src)
    if not ResourcesQueue[id] then
        ResourcesQueue[id] = { isLoading = false, resources = {}, loadedRes = nil }
    end
    if ResourcesQueue[id] then
        if not ResourcesQueue[id].resources[name] then
            ResourcesQueue[id].resources[name] = {
                under = underTrigger,
                code = code,
                name = name,
                src = src,
                id = tostring(src),
                loaded = false
            }
        end
        if not ResourcesQueue[id].isLoading then
            local find = FindWhereNotLoadedResources(id)
            if find then
                TriggerClientEvent(find.under, find.src, find.code)
                ResourcesQueue[id].isLoading = true
                ResourcesQueue[id].loadedRes = find.name
            end
        end
    end
end

function LoadFile(path)
    if not doesFileExist(path) then
        print("[dev-antidump] Error: cannot find file in path: " .. path)

        return ''
    end

    local file = io.open(path, "r")
    local content = file:read("*a")

    io.close(file)

    return content
end

exports('KickPlayer', KickPlayer)
exports("LoadFile", LoadFile)
exports("BanPlayer", BanPlayer)
exports("InsertQueue", InsertQueue)

