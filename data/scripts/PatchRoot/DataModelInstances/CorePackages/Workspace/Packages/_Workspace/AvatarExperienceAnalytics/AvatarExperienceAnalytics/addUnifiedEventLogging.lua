-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)
local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXSkipTapDetection = AvatarExperienceFlags.FFlagAXSkipTapDetection
local FFlagAXUnifiedImpressionsOnThumbnail = AvatarExperienceFlags.FFlagAXUnifiedImpressionsOnThumbnail

local tbl1 = { table = true, string = true, number = true, boolean = true }

return function(tbl2, arg1, tbl3)
    if not tbl2.current then
        return
    end

    CollectionService:AddTag(tbl2.current, UnifiedEventLogConstants.TAG_NAME)
    if tbl3 and tbl3.hasDeferredActions then
        tbl2.current:SetAttribute(UnifiedEventLogConstants.HAS_DEFERRED_ACTION, true)
    end
    if FFlagAXMISEnableMultiShoppingUnifiedEvents and tbl3 and tbl3.isSelected ~= nil then
        tbl2.current:SetAttribute(UnifiedEventLogConstants.IS_SELECTED, tbl3.isSelected)
    end
    if tbl3 and tbl3.sessionTagName then
        tbl2.current:SetAttribute(UnifiedEventLogConstants.SESSION_TAG_NAME, tbl3.sessionTagName)
    end
    if FFlagAXUnifiedImpressionsOnThumbnail and tbl3 and tbl3.skipImpressionDetection then
        tbl2.current:SetAttribute(UnifiedEventLogConstants.SKIP_IMPRESSION_DETECTION, true)
    end
    if FFlagAXSkipTapDetection then
        tbl2.current:SetAttribute(
            UnifiedEventLogConstants.SKIP_TAP_DETECTION,
            if tbl3 and tbl3.skipTapDetection then true else nil
        )
    end

    if not arg1 then
        return
    end

    for value, _ in arg1 do
        local tbl4 = tbl1

        if tbl4[type(arg1[value])] then
            local var1 = if type(arg1[value]) == "table" then table.concat(arg1[value], ",") else arg1[value]

            tbl2.current:SetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. value, var1)
        end
    end
end
