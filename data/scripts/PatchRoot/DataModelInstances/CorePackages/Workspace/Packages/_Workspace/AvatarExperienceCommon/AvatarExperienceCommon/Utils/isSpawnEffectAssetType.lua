-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local Constants = require(AvatarExperienceCommon.Constants)

local function isSpawnEffectAssetType(spawnEffectAssetTypeIdString: string): boolean
    return spawnEffectAssetTypeIdString == Constants.SPAWN_EFFECT_ASSET_TYPE_ID_STRING
end

return isSpawnEffectAssetType
