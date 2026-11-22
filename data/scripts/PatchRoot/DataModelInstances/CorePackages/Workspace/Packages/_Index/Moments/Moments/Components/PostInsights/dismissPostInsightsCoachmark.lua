-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)

local firePostInsightsCoachmarkEvent = require(script.Parent.firePostInsightsCoachmarkEvent)
local postInsightsCoachmarkImpressionCache = require(script.Parent.postInsightsCoachmarkImpressionCache)

local EventNames = MomentsCommon.Analytics.EventNames

local function dismissPostInsightsCoachmark()
    local value = postInsightsCoachmarkImpressionCache.getValue()
    if value < 0 then
        return
    end
    postInsightsCoachmarkImpressionCache.dismissValue()
    if value > 0 then
        firePostInsightsCoachmarkEvent(EventNames.FTUXTooltipDismissed)
    end
end

return dismissPostInsightsCoachmark
