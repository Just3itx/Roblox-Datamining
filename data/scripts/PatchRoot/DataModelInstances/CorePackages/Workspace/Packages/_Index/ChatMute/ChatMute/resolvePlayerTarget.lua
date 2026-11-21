-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getPlayersFromService = require(script.Parent.getPlayersFromService)

local function resolvePlayerTarget(rbxName: string?, userId: string, key: string)
    if not rbxName or rbxName == "" then
        return {
            key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
            args = { RBX_NAME = "" }
        }
    end

    local playersFromService = getPlayersFromService(rbxName)

    if #playersFromService == 0 then
        return {
            key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
            args = { RBX_NAME = rbxName }
        }
    end

    if #playersFromService > 1 then
        return {
            key = "CoreScripts.TextChat.Mute.Error.MultipleMatches",
            args = {}
        }
    end

    local playerInfo = playersFromService[1]

    if playerInfo.userId == userId then
        return {
            key = "CoreScripts.TextChat.Mute.Error.CannotMuteSelf",
            args = {}
        }
    end

    return {
        key = key,
        args = {
            RBX_NAME = if string.sub(string.lower(rbxName), 1, 1) == "@" then "@" .. playerInfo.username else playerInfo.displayName
        },
        playerInfo = playerInfo
    }
end

return resolvePlayerTarget
