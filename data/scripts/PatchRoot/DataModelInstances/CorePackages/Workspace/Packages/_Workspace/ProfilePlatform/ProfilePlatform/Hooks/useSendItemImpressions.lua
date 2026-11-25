-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local RoactAnalytics = require(ProfilePlatformParent.RoactServiceTags).RoactAnalytics

local AppEventIngestService = require(ProfilePlatformParent.RoactServiceTags).AppEventIngestService

local SendItemImpressions = require(ProfilePlatformParent.UnifiedLogging).SendItemImpressions

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)

local EventNames = require(ProfilePlatform.Analytics.EventNames)

return function(tbl1, num1: number, str1: string, num2: number, component: string)
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useRoactService(RoactAnalytics)
    local profilePlatform = AppPage.ProfilePlatform
    local var3 = useProfileAnalyticsContext()

    return React.useCallback(function(arg1)
        var3.fireAnalyticsEvent(EventNames.ProfileImpressionsSent, { component = component })

        if SendItemImpressions and SendItemImpressions.sendFromProfile then
            SendItemImpressions.sendFromProfile(var1, var2, arg1, tbl1, num1, profilePlatform, str1, num2, component)
        end
    end, {
        var2,
        num2,
        component,
        str1,
        var1,
        profilePlatform,
        tbl1,
        num1,
        SendItemImpressions
    })
end
