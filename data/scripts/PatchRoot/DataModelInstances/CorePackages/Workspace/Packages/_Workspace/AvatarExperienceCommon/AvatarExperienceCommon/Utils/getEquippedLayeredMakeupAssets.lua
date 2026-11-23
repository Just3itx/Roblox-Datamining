-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)

local function getEquippedLayeredMakeupAssets(tbl1)
    if tbl1 == nil then
        return {}
    end

    local equippedLayeredMakeupAssets = {}
    for value, _ in Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE do
        if not tbl1[value] then
            continue
        end

        for _, value2 in tbl1[value] do
            table.insert(equippedLayeredMakeupAssets, value2)
        end
    end

    return equippedLayeredMakeupAssets
end

return getEquippedLayeredMakeupAssets
