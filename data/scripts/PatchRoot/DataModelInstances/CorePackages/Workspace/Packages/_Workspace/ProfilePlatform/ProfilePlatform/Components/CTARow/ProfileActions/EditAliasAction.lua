-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SetAlias = require(ProfilePlatformParent.SetAlias)
local SocialStopwatch = require(ProfilePlatformParent.SocialStopwatch)

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.EditAlias] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.EditAlias],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CustomizeNameOpened)
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonSetAlias, { buttonSurface = arg1.buttonSurface })

        arg1.navigation.navigate(
            Enums.Screens.SetAliasModal,
            {
                profileUserId = arg1.profileId,
                origin = SetAlias.Analytics.EntryPoints.ContextualMenu
            }
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
