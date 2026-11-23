-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local Constants = require(AvatarExperienceCommon.Constants)

return function(arg1)
    local equippedAssets = arg1.AvatarExperience.AvatarEditor.Character.EquippedAssets

    if equippedAssets == nil then
        return {}
    end

    local result = {}

    for value, _ in Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE do
        if not equippedAssets[value] then
            continue
        end

        for _, value2 in equippedAssets[value] do
            table.insert(result, value2)
        end
    end

    return result
end
