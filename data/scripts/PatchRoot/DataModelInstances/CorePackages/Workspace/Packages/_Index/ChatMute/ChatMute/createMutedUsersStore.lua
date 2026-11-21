-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatMuteParent = script:FindFirstAncestor("ChatMute").Parent
local createSignal = require(ChatMuteParent.Signals).createSignal

return function()
    local getMutedUsernames, var2 = createSignal({})
    local getMutedDisplayNames, var4 = createSignal({})
    local getMutedUserIds, var6 = createSignal({})

    return {
        getMutedUsernames = getMutedUsernames,
        getMutedDisplayNames = getMutedDisplayNames,
        getMutedUserIds = getMutedUserIds,
        muteGlobalUsername = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedUsernames(false))
            var7[str2] = true
            var2(var7)
        end,
        unmuteGlobalUsername = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedUsernames(false))
            var7[str2] = nil
            var2(var7)
        end,
        muteGlobalDisplayName = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedDisplayNames(false))
            var7[str2] = true
            var4(var7)
        end,
        unmuteGlobalDisplayName = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedDisplayNames(false))
            var7[str2] = nil
            var4(var7)
        end,
        isUsernameMuted = function(str1: string): boolean
            return getMutedUsernames(false)[string.lower(str1)] == true
        end,
        isDisplayNameMuted = function(str1: string): boolean
            return getMutedDisplayNames(false)[string.lower(str1)] == true
        end,
        muteGlobalUserId = function(arg1)
            local str1 = tostring(arg1)
            local var7 = table.clone(getMutedUserIds(false))
            var7[str1] = true
            var6(var7)
        end,
        unmuteGlobalUserId = function(arg1)
            local str1 = tostring(arg1)
            local var7 = table.clone(getMutedUserIds(false))
            var7[str1] = nil
            var6(var7)
        end,
        isUserIdMuted = function(arg1): boolean
            return getMutedUserIds(false)[tostring(arg1)] == true
        end
    }
end
