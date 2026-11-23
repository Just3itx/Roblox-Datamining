-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local AbuseVector = require(AvatarExperienceCommonParent.UniversalFeatureRestrictions.AbuseVector)
local showFeatureRestriction = require(AvatarExperienceCommonParent.UniversalFeatureRestrictions.showFeatureRestriction)
local getTimeoutStatusStore = require(AvatarExperienceCommon.Stores.TimeoutStatusStore.getTimeoutStatusStore)

local FFlagAXTimeoutAcknowledgementGating = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXTimeoutAcknowledgementGating

local function showAvatarChangeFeatureRestriction()
    if not FFlagAXTimeoutAcknowledgementGating then
        showFeatureRestriction(AbuseVector.AvatarChange)
        return
    end

    task.spawn(function()
        showFeatureRestriction(AbuseVector.AvatarChange, {
            onAcknowledgementSuccess = function()
                local timeoutStatusStore = getTimeoutStatusStore(false)

                if not timeoutStatusStore.clearStatusIfServed() then
                    timeoutStatusStore.refreshStatus()
                end
            end
        })
    end)
end

return showAvatarChangeFeatureRestriction
