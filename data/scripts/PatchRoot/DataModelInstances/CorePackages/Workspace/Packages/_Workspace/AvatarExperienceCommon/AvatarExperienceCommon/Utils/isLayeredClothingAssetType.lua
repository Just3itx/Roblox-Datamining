-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)

local function isLayeredClothingAssetType(str1: string): boolean
    return Constants.LAYERED_ASSET_TYPES[str1] ~= nil
end

return isLayeredClothingAssetType
