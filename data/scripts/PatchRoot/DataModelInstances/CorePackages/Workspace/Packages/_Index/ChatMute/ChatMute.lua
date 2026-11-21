-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetMutedUsersStore = require(script.GetMutedUsersStore)

local function store() -- Luacid: Inlined by compiler; 12 call sites recovered
    return GetMutedUsersStore(false)
end

local module = {}

function module.mutePlayer(tbl1)
    if tbl1.userId then
        store().muteGlobalUserId(tbl1.userId)
    end
    if tbl1.username then
        store().muteGlobalUsername(tbl1.username)
    end
    if tbl1.displayName then
        store().muteGlobalDisplayName(tbl1.displayName)
    end
end

function module.unmutePlayer(tbl1)
    if tbl1.userId then
        store().unmuteGlobalUserId(tbl1.userId)
    end
    if tbl1.username then
        store().unmuteGlobalUsername(tbl1.username)
    end
    if tbl1.displayName then
        store().unmuteGlobalDisplayName(tbl1.displayName)
    end
end

function module.isUserIdMuted(arg1)
    return store().isUserIdMuted(arg1)
end

function module.isUsernameMuted(str1: string)
    return store().isUsernameMuted(str1)
end

function module.isDisplayNameMuted(str1: string)
    return store().isDisplayNameMuted(str1)
end

function module.getMutedUserIds()
    return store().getMutedUserIds
end

function module.getMutedUsernames()
    return store().getMutedUsernames
end

function module.getMutedDisplayNames()
    return store().getMutedDisplayNames
end

module.resolveMuteTarget = require(script.resolveMuteTarget)
module.resolveUnmuteTarget = require(script.resolveUnmuteTarget)
module.getPlayersFromService = require(script.getPlayersFromService)

module["jest.config"] = script["jest.config"]
return module
