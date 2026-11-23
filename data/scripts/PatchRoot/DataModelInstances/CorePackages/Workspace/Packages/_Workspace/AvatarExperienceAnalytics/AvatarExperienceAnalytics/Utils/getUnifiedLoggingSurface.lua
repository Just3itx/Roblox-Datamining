-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface

local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local function getUnifiedLoggingSurface(arg1)
    local var1 = if arg1 and arg1.opaque then AvatarScreenProperties[arg1.opaque.name] else nil
    local unifiedLoggingSurface = if var1 and var1.analyticsData then var1.analyticsData.unifiedLoggingSurface else nil

    if not unifiedLoggingSurface then
        if FFlagAXUnifiedEventStrictPayloads then
            return UnifiedLoggingSurface.UNDEFINED_SURFACE
        end

        unifiedLoggingSurface = nil
    end

    return unifiedLoggingSurface
end

return getUnifiedLoggingSurface
