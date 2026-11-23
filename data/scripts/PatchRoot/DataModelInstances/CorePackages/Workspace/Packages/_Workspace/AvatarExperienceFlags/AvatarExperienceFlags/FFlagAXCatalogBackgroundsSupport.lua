-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)

local success = pcall(function(): Enum.AvatarAssetType
    return Enum.AvatarAssetType.AvatarBackground
end)

return game:DefineFastFlag("AXCatalogBackgroundsSupport", false) and FFlagAXBackgroundsRoot and success
