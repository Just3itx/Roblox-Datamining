-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local AvatarScreenProperties = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).AvatarRoute.AvatarScreenProperties

local function resolveClickSurface(arg1, arg2)
    if arg1:GetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "surface") ~= nil then
        return nil
    end
    if not (arg2 and arg2.current and arg2.opaque) then
        return nil
    end

    local var1 = AvatarScreenProperties[arg2.opaque.name]
    return if var1 and var1.analyticsData then var1.analyticsData.unifiedLoggingSurface else nil
end

return resolveClickSurface
