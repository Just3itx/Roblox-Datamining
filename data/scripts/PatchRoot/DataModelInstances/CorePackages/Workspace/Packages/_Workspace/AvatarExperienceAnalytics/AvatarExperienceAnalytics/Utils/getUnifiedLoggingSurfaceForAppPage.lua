-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local AvatarScreenProperties = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).AvatarRoute.AvatarScreenProperties

local function getUnifiedLoggingSurfaceForAppPage(str1: string?)
    if typeof(str1) ~= "string" or str1 == "" then
        return nil
    end
    local var1 = AvatarScreenProperties[str1]
    return if var1 and var1.analyticsData then var1.analyticsData.unifiedLoggingSurface else nil
end

return getUnifiedLoggingSurfaceForAppPage
