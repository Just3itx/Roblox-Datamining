-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagProfileAboutDetailsUseSheet = SharedFlags.FFlagProfileAboutDetailsUseSheet

return {
    [Enums.ProfileActions.ViewAbout] = FFlagProfilePlatformNewProfileHeader and function(arg1)
        local tbl1 = {
            text = arg1.localized[Enums.ProfileActions.ViewAbout],
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            arg1.analytics.fireAnalyticsEvent(
                EventNames.CTAButtonViewFullProfile,
                {
                    buttonSurface = arg1.buttonSurface,
                    btnContext = arg1.profileWrapperContext.sourceInfo.source
                }
            )
            local tbl3 = {
                name = AppPage.AboutDetailsSheet,
                extraProps = {
                    sections = arg1.aboutSections,
                    profileName = if FFlagProfileAboutDetailsUseSheet then arg1.aboutProfileName else nil
                }
            }

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
                return
            end
            arg1.dispatch(NavigateDown(tbl3))
        end

        tbl1.onActivated = onActivated
        return tbl1
    end or nil
}
