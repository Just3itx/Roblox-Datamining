-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch
local EditProfileBackground = require(ProfilePlatformParent.EditProfileBackground)
local refreshProfilePlatformUserInfo = require(ProfilePlatform.Networking.refreshProfilePlatformUserInfo)
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local Enums = require(ProfilePlatform.Common.Enums)

local DefaultAnalyticsService = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.DefaultAnalyticsService
local Analytics = require(ProfilePlatformParent.EditProfileBackground).Analytics

local function EditProfileBackgroundPageWrapper(_)
    local var1 = useDispatch()
    local var2 = useLocalUserId()

    local profileBackgroundData = useProfileJsonComponent(Enums.Components.ProfileBackground)

    local onBackgroundChanged = React.useCallback(function()
        var1(refreshProfilePlatformUserInfo(tostring(var2)))
    end)

    local fireAnalyticsEvent = Analytics.setupFireAnalyticsEvents({
        analytics = {
            EventStream = DefaultAnalyticsService.EventStream,
            Telemetry = DefaultAnalyticsService.Telemetry
        },
        infoForAllEvents = {
            uid = tostring(var2)
        }
    })

    return React.createElement(Analytics.Context.Provider, {
        value = { fireAnalyticsEvent = fireAnalyticsEvent }
    }, { React.createElement(
            EditProfileBackground.EditProfileBackgroundPage,
            {
                onBackgroundChanged = onBackgroundChanged,
                profileBackgroundData = profileBackgroundData
            }
        ) })
end

return EditProfileBackgroundPageWrapper
