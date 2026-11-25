-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Http = require(ProfilePlatformParent.Http)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)

local Url = Http.Url
local AppPage = RobloxAppEnums.AppPage

local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)

return {
    [Enums.ProfileActions.TradeItems] = FFlagProfilePlatformEnableTradeItems and function(arg1)
        local tbl1 = {
            text = arg1.localized[Enums.ProfileActions.TradeItems],
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            if arg1.buttonSurface == Enums.ButtonSurface.ContextualMenu then
                arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonTradeItems, { buttonSurface = arg1.buttonSurface })
            else
                arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonTradeItems, { buttonSurface = arg1.buttonSurface })
            end

            local tbl3 = {
                name = AppPage.GenericWebPage,
                detail = `{Url.BASE_URL}users/{arg1.profileId}/trade`,
                extraProps = {
                    titleKey = TextKeys.TradeItems
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
