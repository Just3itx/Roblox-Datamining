-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local t = require(DataHydrationParent.t)

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

return {
    mediaAssetResponseItemValidator = t.interface({
        imageId = t.optional(t.union(t.number, t.string)),
        assetTypeId = t.optional(t.number),
        videoId = t.optional(t.union(t.number, t.string)),
        videoHash = t.optional(t.string),
        videoTitle = t.optional(t.string)
    })
}
