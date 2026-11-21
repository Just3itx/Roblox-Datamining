-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local EditProfileIXP = require(EditProfile.Flags.EditProfileIXP)

local Analytics = require(EditProfile.Analytics)
local DefaultAnalyticsService = require(EditProfileParent.SocialLuaAnalytics).Analytics.DefaultAnalyticsService

local EditUsernameWrapper = require(script.Parent.EditUsernameWrapper)

return function(arg1)
    local uid = useLocalUserId()

    if not EditProfileIXP.useIsExperimentEnabled() then
        return React.createElement(EditUsernameWrapper, arg1)
    end

    return React.createElement(Analytics.Context.Provider, {
        value = {
            fireAnalyticsEvent = Analytics.setupFireAnalyticsEvents({ analytics = DefaultAnalyticsService, infoForAllEvents = { uid = uid } })
        }
    }, { React.createElement(EditUsernameWrapper, arg1) })
end
