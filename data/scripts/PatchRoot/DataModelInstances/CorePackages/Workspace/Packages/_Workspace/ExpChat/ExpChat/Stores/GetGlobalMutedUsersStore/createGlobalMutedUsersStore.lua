-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

return function()
    local getMutedGlobalUsernames, var2 = createSignal({})
    local getMutedGlobalDisplayNames, var4 = createSignal({})
    local getMutedGlobalUserIds, var6 = createSignal({})

    return {
        getMutedGlobalUsernames = getMutedGlobalUsernames,
        getMutedGlobalDisplayNames = getMutedGlobalDisplayNames,
        getMutedGlobalUserIds = getMutedGlobalUserIds,
        muteGlobalUsername = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedGlobalUsernames(false))
            var7[str2] = true
            var2(var7)
        end,
        unmuteGlobalUsername = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedGlobalUsernames(false))
            var7[str2] = nil
            var2(var7)
        end,
        muteGlobalDisplayName = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedGlobalDisplayNames(false))
            var7[str2] = true
            var4(var7)
        end,
        unmuteGlobalDisplayName = function(str1: string)
            local str2 = string.lower(str1)
            local var7 = table.clone(getMutedGlobalDisplayNames(false))
            var7[str2] = nil
            var4(var7)
        end,
        isUsernameMuted = function(str1: string): boolean
            return getMutedGlobalUsernames(false)[string.lower(str1)] == true
        end,
        isDisplayNameMuted = function(str1: string): boolean
            return getMutedGlobalDisplayNames(false)[string.lower(str1)] == true
        end,
        muteGlobalUserId = function(arg1)
            local str1 = tostring(arg1)
            local var7 = table.clone(getMutedGlobalUserIds(false))
            var7[str1] = true
            var6(var7)
        end,
        unmuteGlobalUserId = function(arg1)
            local str1 = tostring(arg1)
            local var7 = table.clone(getMutedGlobalUserIds(false))
            var7[str1] = nil
            var6(var7)
        end,
        isUserIdMuted = function(arg1): boolean
            return getMutedGlobalUserIds(false)[tostring(arg1)] == true
        end
    }
end
