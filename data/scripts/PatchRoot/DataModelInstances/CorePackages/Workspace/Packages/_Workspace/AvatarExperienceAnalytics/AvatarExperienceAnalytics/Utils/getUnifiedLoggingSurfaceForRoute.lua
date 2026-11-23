-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface

local getUnifiedLoggingSurface = require(script.Parent.getUnifiedLoggingSurface)

local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local function getUnifiedLoggingSurfaceForRoute(arg1)
    if arg1 == nil then
        return if FFlagAXUnifiedEventStrictPayloads then UnifiedLoggingSurface.UNDEFINED_SURFACE else nil
    end

    local name = if arg1.current then arg1.current.name else nil
    local var1 = if name then AvatarScreenProperties[name] else nil
    local unifiedLoggingSurface = if var1 and var1.analyticsData then var1.analyticsData.unifiedLoggingSurface else nil

    if var1 and var1.isTransparent and unifiedLoggingSurface ~= nil then
        return unifiedLoggingSurface
    end
    if not FFlagAXUnifiedEventStrictPayloads then
        return getUnifiedLoggingSurface(arg1) or unifiedLoggingSurface
    end

    local unifiedLoggingSurface2 = getUnifiedLoggingSurface(arg1)
    return if unifiedLoggingSurface2 == UnifiedLoggingSurface.UNDEFINED_SURFACE then if unifiedLoggingSurface == nil then UnifiedLoggingSurface.UNDEFINED_SURFACE else unifiedLoggingSurface else unifiedLoggingSurface2
end

return getUnifiedLoggingSurfaceForRoute
