-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)

local function isMakeupAssetType(str1: string): boolean
    return Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[str1] ~= nil
end

return isMakeupAssetType
