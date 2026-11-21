-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local DeviceTier = require(AvatarExperienceCatalogParent.Devices).DeviceTier

local num1 = game:DefineFastInt("AXWidgetListWindowSizeLow", 5)
local num2 = game:DefineFastInt("AXWidgetListWindowSizeMid", 8)
local num3 = game:DefineFastInt("AXWidgetListWindowSizeHigh", 11)

local function resolveWidgetListWindowSize(num4: number): number
    local deviceMemoryTier = DeviceTier.GetDeviceMemoryTier()

    return if deviceMemoryTier == "LowEnd" then num1 elseif deviceMemoryTier == "MidTier" then num2 elseif deviceMemoryTier == "HighEnd" then num3 else num4
end

return resolveWidgetListWindowSize
