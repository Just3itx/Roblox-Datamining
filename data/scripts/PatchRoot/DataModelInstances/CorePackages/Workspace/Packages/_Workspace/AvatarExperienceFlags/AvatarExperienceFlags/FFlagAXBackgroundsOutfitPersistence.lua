-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXOutfitDetailsV4 = require(script.Parent.FFlagAXOutfitDetailsV4)

local bool1 = game:DefineFastFlag("AXBackgroundsOutfitPersistence", false)

local success = pcall(function(): Enum.AvatarAssetType
    return Enum.AvatarAssetType.AvatarBackground
end)

return FFlagAXBackgroundsRoot and FFlagAXOutfitDetailsV4 and bool1 and success
