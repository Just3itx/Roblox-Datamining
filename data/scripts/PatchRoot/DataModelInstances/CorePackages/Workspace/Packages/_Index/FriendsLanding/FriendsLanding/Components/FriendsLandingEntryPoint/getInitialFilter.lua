-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")

local filterStates = require(FriendsLanding.Friends.filterStates)

local tbl1 = {
    all = filterStates.All,
    online = filterStates.Online,
    trusted = filterStates.Trusted
}

local function getInitialFilter(str1: string?)
    if str1 == nil then
        return filterStates.All
    end

    return tbl1[string.lower(str1)] or filterStates.All
end

return getInitialFilter
