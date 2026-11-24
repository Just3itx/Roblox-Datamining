-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _Signals = require(DataHydrationParent.Signals)
local t = require(DataHydrationParent.t)

return {
    followingResponseValidator = t.interface({
        UniverseId = t.number,
        UserId = t.number,
        CanFollow = t.boolean,
        IsFollowing = t.boolean,
        FollowingCountByType = t.optional(t.number),
        FollowingLimitByType = t.optional(t.number)
    })
}
