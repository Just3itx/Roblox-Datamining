-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)
local _CategoryTypes = require(AvatarExperienceCommon.Types.CategoryTypes.CategoryTypes)
local _CommonTypes = require(AvatarExperienceCommon.Types.CommonTypes)

local function createHumanoidDescriptionAccessoryInfo(arg1, arg2, tbl1)
    local assetId = tonumber(arg2)
    assert(assetId ~= nil, "assetIdAsNumber is not nil. Silence type checker.")
    tbl1 = tbl1 or {}
    return {
        AssetId = assetId,
        Order = tbl1.order,
        AccessoryType = tbl1.type or Constants.ASSET_TYPE_TO_ACCESSORY_TYPE[arg1],
        IsLayered = tbl1.isLayered,
        Position = tbl1.position,
        Rotation = tbl1.rotation,
        Scale = tbl1.scale
    }
end

return createHumanoidDescriptionAccessoryInfo
