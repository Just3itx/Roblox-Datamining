-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE = require(AvatarExperienceCommon.Constants).ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE
local destroyMakeupDescriptions = require(AvatarExperienceCommon.Utils.Humanoid.destroyMakeupDescriptions)

local function setMakeupDescriptions(parent, tbl1)
    destroyMakeupDescriptions(parent)

    for value, value2 in tbl1 do
        if not ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[value] then
            continue
        end

        for value3, value4 in value2 do
            local makeupDescription = Instance.new("MakeupDescription")
            makeupDescription.MakeupType = ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[value]
            makeupDescription.AssetId = tonumber(value3) or 0
            makeupDescription.Parent = parent
            if value4.order then
                makeupDescription.Order = value4.order
            end
        end
    end
end

return setMakeupDescriptions
