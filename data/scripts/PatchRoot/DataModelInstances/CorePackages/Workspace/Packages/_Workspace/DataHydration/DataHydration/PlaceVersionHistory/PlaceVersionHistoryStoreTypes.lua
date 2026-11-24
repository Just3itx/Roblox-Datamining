-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _Signals = require(DataHydrationParent.Signals)

return {
    SaveType = { Null = 0, AutoSave = 1, ManualSave = 2 },
    PublishStatus = { NotPublished = 0, Live = 1, PreviouslyPublished = 2 }
}
