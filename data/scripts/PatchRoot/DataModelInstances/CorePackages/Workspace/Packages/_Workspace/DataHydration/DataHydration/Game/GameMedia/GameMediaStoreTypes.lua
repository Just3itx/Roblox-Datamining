-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local t = require(DataHydrationParent.t)

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local MediaAssetStoreTypes = require(DataHydration.MediaAsset.MediaAssetStoreTypes)

return {
    gameMediaResponseValidator = t.interface({ data = t.array(MediaAssetStoreTypes.mediaAssetResponseItemValidator) })
}
