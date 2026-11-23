-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local _AvatarExperienceModel = require(AvatarExperienceCommon.Parent.AvatarExperienceModel)

local Constants = require(AvatarExperienceCommon.Constants)

function removeMakeupAssetsFromTryOnsIfOverLimit(tbl1)
    local num1 = 0
    local huge = math.huge
    for _, value in tbl1 do
        if Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[value.itemSubType] then
            num1 += 1
            huge = math.min(value.itemRecency, huge)
        end
    end

    if Constants.MAX_MAKEUP_LAYERS < num1 then
        for value, value2 in tbl1 do
            if value2.itemRecency == huge then
                tbl1[value] = nil
            end
        end
    end

    return tbl1
end

return removeMakeupAssetsFromTryOnsIfOverLimit
