-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local FFlagEnablePlatformProfileContextualMenuOption = require(ProfilePlatformParent.SharedFlags).FFlagEnablePlatformProfileContextualMenuOption

local getPlatformFriendsService = require(ProfilePlatform.Utils.getPlatformFriendsService)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

return {
    [Enums.ProfileActions.ViewPlatformProfile] = FFlagEnablePlatformProfileContextualMenuOption and function(arg1): {onActivated: number, text: any}?
        local profilePlatformId = arg1.profileWrapperContext.profilePlatformId
        if not profilePlatformId or profilePlatformId == "" then
            return nil
        end

        local tbl1 = {
            text = arg1.localized[Enums.ProfileActions.ViewPlatformProfile],
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            arg1.analytics.fireAnalyticsEvent(
                EventNames.ContextualMenuButtonViewPlatformProfile,
                {
                    buttonSurface = arg1.buttonSurface
                }
            )
            getPlatformFriendsService:ShowProfile(arg1.profileWrapperContext.profilePlatformId)
        end

        tbl1.onActivated = onActivated
        return tbl1
    end or nil
}
