-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:12Z
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
local CloseCentralOverlay = require(ProfilePlatformParent.CentralOverlay).Thunks.CloseCentralOverlay
local AbuseVector = require(ProfilePlatformParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(ProfilePlatformParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagEnableAbuseReportRevampFlow = SharedFlags.FFlagEnableAbuseReportRevampFlow

local FFlagEnableAbuseReportRevampProfileAndGroup = require(ProfilePlatform.Flags.FFlagEnableAbuseReportRevampProfileAndGroup)

local module = {}
module[Enums.ProfileActions.Report] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.Report],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonReport, { buttonSurface = arg1.buttonSurface })

        if FFlagEnableAbuseReportRevampFlow and FFlagEnableAbuseReportRevampProfileAndGroup then
            arg1.dispatch(
                OpenDynamicAbuseReport({
                    abuseVector = AbuseVector.UserProfile,
                    targetId = arg1.profileId,
                    onClose = function()
                        arg1.dispatch(CloseCentralOverlay())
                        arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
                    end
                })
            )

            return
        end

        local tbl3 = {
            name = AppPage.GenericWebPage,
            detail = `{Url.BASE_URL}abusereport/userprofile?id={arg1.profileId}`,
            extraProps = {
                titleKey = TextKeys.Report
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        arg1.dispatch(NavigateDown(tbl3))
    end

    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonReport, { buttonSurface = arg1.buttonSurface })

        if FFlagEnableAbuseReportRevampFlow and FFlagEnableAbuseReportRevampProfileAndGroup then
            arg1.dispatch(
                OpenDynamicAbuseReport({
                    abuseVector = AbuseVector.Group,
                    targetId = arg1.profileId,
                    onClose = function()
                        arg1.dispatch(CloseCentralOverlay())
                        arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
                    end
                })
            )

            return
        end

        local tbl3 = {
            name = AppPage.GenericWebPage,
            detail = `{Url.BASE_URL}abusereport/group?id={arg1.profileId}`,
            extraProps = {
                titleKey = TextKeys.Report
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
end

return module
