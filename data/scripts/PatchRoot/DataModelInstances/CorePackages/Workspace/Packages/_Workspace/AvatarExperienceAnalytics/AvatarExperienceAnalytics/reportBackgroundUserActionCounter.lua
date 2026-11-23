-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)

local Constants = require(script.Parent.Constants)
local sendAXCounterV2 = require(script.Parent.sendAXCounterV2)

local AvatarBackground = AvatarExperienceCommon.Constants.ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground

local tbl1 = {
    Equip = Constants.AVATAR_EVENT_COUNTER_NAME.AXEquipBackground,
    Unequip = Constants.AVATAR_EVENT_COUNTER_NAME.AXUnequipBackground,
    TryOn = Constants.AVATAR_EVENT_COUNTER_NAME.AXTryOnBackground,
    RemoveTryOn = Constants.AVATAR_EVENT_COUNTER_NAME.AXRemoveTryOnBackground
}

local module = {}

function module.report(str1: string)
    sendAXCounterV2(tbl1[str1])
end

function module.reportIfAvatarBackgroundAsset(str1: string, str2: string?, str3: string?)
    if AvatarBackground and str2 == "Asset" and str3 == AvatarBackground then
        module.report(str1)
    end
end

return module
