-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local VRService = game:GetService("VRService")

local AppLinking = require(GenericAbuseReportingParent.RoactServiceTags).AppLinking
local default = require(GenericAbuseReportingParent.LinkingProtocol).LinkingProtocol.default
local NavigationRodux = require(GenericAbuseReportingParent.NavigationRodux)
local React = require(GenericAbuseReportingParent.React)
local Responsive = require(GenericAbuseReportingParent.Responsive)
local RoactUtils = require(GenericAbuseReportingParent.RoactUtils)
local RobloxAppEnums = require(GenericAbuseReportingParent.RobloxAppEnums)
local RobloxAppHooks = require(GenericAbuseReportingParent.RobloxAppHooks)

local AppPage = RobloxAppEnums.AppPage
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local usePreferredInput = Responsive.usePreferredInput
local useRoactService = RobloxAppHooks.useRoactService

local FFlagSignalsNavP3Dispatch = require(GenericAbuseReportingParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GenericAbuseReportingParent.RobloxAppNavigation).NavigationCommands else nil

local function useOpenLink()
    local var1 = useDispatch()
    local var2 = useRoactService(AppLinking)
    local bool1 = usePreferredInput() == Responsive.Input.Directional

    return React.useCallback(function(title: string, detail: string?)
        if not detail then
            return
        end

        if not var2 then
            default:openURL(detail)
            return
        end

        if bool1 or VRService.VREnabled then
            var2:openURL(detail)
            return
        end
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = { title = title }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1))
    end, { var2, var1, bool1 })
end

return useOpenLink
