-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXBackgroundCycloramaRendering = require(script.Parent.FFlagAXBackgroundCycloramaRendering)

local bool1 = game:DefineFastFlag("AXBackgroundsCustomizeHydration4", false)

local success = pcall(function(): Enum.AvatarAssetType
    return Enum.AvatarAssetType.AvatarBackground
end)

return FFlagAXBackgroundsRoot and FFlagAXBackgroundCycloramaRendering and bool1 and success
