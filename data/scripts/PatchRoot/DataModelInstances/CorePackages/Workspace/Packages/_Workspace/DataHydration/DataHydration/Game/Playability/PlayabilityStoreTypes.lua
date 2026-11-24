-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local t = require(DataHydrationParent.t)
local DiscoveryTypes = require(DataHydrationParent.DiscoveryTypes)

return {
    playabilityResponseValidator = t.array(t.interface({ universeId = t.number, isPlayable = t.boolean, playabilityStatus = t.optional(t.string) })),
    PlayabilityStatusEnum = DiscoveryTypes.PlayabilityStatusEnum
}
