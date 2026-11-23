-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local React = require(AvatarExperienceAnalyticsParent.React)
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)

local addUnifiedEventLogging = require(script.Parent.addUnifiedEventLogging)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)

local FFlagAXUnifiedEventStrictPayloads = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local tbl1 = {
    hasDeferredActions = true,
    sessionTagName = UnifiedEventLogConstants.L2_SESSION_TAG_NAME
}

local function useUnifiedEventTagging(tbl2)
    local var1 = React.useMemo(function()
        if not FFlagAXUnifiedEventStrictPayloads then
            return Cryo.Dictionary.join(
                {
                    hasDeferredActions = true,
                    sessionTagName = UnifiedEventLogConstants.L2_SESSION_TAG_NAME
                },
                tbl2.options or {}
            )
        end

        local options = tbl2.options
        if options == nil then
            return tbl1
        end
        return {
            hasDeferredActions = if options.hasDeferredActions == nil then tbl1.hasDeferredActions else options.hasDeferredActions,
            sessionTagName = if options.sessionTagName == nil then tbl1.sessionTagName else options.sessionTagName,
            isSelected = options.isSelected,
            skipImpressionDetection = options.skipImpressionDetection,
            skipTapDetection = options.skipTapDetection
        }
    end, { tbl2.options })

    React.useEffect(function()
        if tbl2.isReady == false then
            return
        end
        addUnifiedEventLogging(tbl2.ref, tbl2.payload, var1)
    end, {
        tbl2.ref,
        tbl2.payload,
        tbl2.isReady,
        var1
    })
end
return useUnifiedEventTagging
