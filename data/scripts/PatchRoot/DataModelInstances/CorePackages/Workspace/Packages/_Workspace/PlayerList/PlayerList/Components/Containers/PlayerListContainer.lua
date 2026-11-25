-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local ReactFocusNavigation = require(scriptParentParentParentParent.ReactFocusNavigation)
local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local LocalizationService = game:GetService("LocalizationService")
local InExperienceLocales = require(scriptParentParentParentParent.InExperienceLocales)
local LocalizationProvider = require(scriptParentParentParentParent.Localization).LocalizationProvider

local LeaderboardStoreContext = require(scriptParentParentParent.Common.LeaderboardStoreContext)
local LayoutValuesContext = require(scriptParentParentParent.Common.LayoutValuesContext)
local GameTextTranslatorContext = require(scriptParentParentParent.Common.GameTextTranslatorContext)
local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)

local CreateLayoutValues = require(scriptParentParentParent.Common.CreateLayoutValues)
local PlatformLeaderboardContainer = require(scriptParentParentParent.Components.Containers.PlatformLeaderboardContainer)

local FocusNavigationContext = ReactFocusNavigation.FocusNavigationContext
local FocusNavigationService = ReactFocusNavigation.FocusNavigationService

local FFlagAddNewPlayerListFocusNav = require(scriptParentParentParent.Flags.FFlagAddNewPlayerListFocusNav)
local FFlagEnablePlayerListExposureEvents = require(scriptParentParentParent.Flags.FFlagEnablePlayerListExposureEvents)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local FFlagPlayerListReskin = require(scriptParentParentParent.Flags.FFlagPlayerListReskin)
local FStringPlayerListIXPLayer = require(scriptParentParentParent.Flags.FStringPlayerListIXPLayer)

local IXPService = game:GetService("IXPService")

local LeaderboardViewChangeTelemetry = nil
local function getLeaderboardViewChangeTelemetry() -- Luacid: Inlined by compiler; 1 call site recovered
    if LeaderboardViewChangeTelemetry == nil then
        LeaderboardViewChangeTelemetry = require(scriptParentParentParent.Common.LeaderboardViewChangeTelemetry)
    end
    return LeaderboardViewChangeTelemetry
end

return React.memo(function(tbl1)
    local layoutValues, focusNavigationService

    if FFlagPlayerListReskin then
        layoutValues = React.useMemo(function()
            return CreateLayoutValues(tbl1.isTenFoot or false, tbl1.TopBarConstants)
        end, { tbl1.isTenFoot, tbl1.TopBarConstants })
        focusNavigationService = React.useMemo(function()
            return FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
        end, {})
    else
        layoutValues = CreateLayoutValues(tbl1.isTenFoot or false, tbl1.TopBarConstants)
        focusNavigationService = FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end
    local value = SignalsReact.useSignalState(tbl1.leaderboardStore)

    if FFlagEnablePlayerListExposureEvents then
        React.useEffect(function()
            IXPService:LogFlagLinkedUserLayerExposure(FStringPlayerListIXPLayer)
        end, {})
    end

    local localization = if FFlagPlayerListLocalizeGameText then React.useMemo(function()
        return InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {}) else nil

    if FFlagPlayerListReskin then
        React.useEffect(function()
            local bool1 = false
            return Signals.createEffect(function(arg1)
                local effectiveVisible = PlayerListVisibilityStore.getEffectiveVisible(arg1)
                if bool1 then
                    getLeaderboardViewChangeTelemetry().logVisibility(effectiveVisible, true)
                    return
                end
                bool1 = true
            end)
        end, {})
    end

    local var3 = if FFlagPlayerListReskin then React.createElement(PlatformLeaderboardContainer, {}, tbl1.children) else tbl1.children
    local element = React.createElement(LeaderboardStoreContext.Provider, { value = value }, {
        LayoutValuesProvider = React.createElement(
            LayoutValuesContext.Provider,
            { value = layoutValues },
            FFlagAddNewPlayerListFocusNav
                and {
                    FocusNavigationProvider = React.createElement(FocusNavigationContext.Provider, { value = focusNavigationService }, var3)
                }
                or var3
        )
    })

    if FFlagPlayerListLocalizeGameText and tbl1.translateGameText then
        element = React.createElement(
            GameTextTranslatorContext.Provider,
            {
                value = tbl1.translateGameText
            },
            { LeaderboardStoreProvider = element }
        )
    end

    if not FFlagPlayerListLocalizeGameText then
        return element
    end

    return React.createElement(LocalizationProvider, { localization = localization }, { LeaderboardTree = element })
end)
