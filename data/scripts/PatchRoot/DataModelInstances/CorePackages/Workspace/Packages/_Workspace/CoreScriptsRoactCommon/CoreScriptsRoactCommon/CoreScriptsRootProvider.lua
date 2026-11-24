-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local LocalizationService = game:GetService("LocalizationService")

local isTenFootInterface = require(scriptParentParent.AppCommonLib).isTenFootInterface
local Localization = if game:DefineFastFlag("SwitchCSRootProviderTranslationsPackage", false) then require(scriptParentParent.InExperienceLocales).Localization else require(scriptParentParent.RobloxAppLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider
local DesignTokenProvider = require(scriptParentParent.Style).DesignTokenProvider
local Cryo = require(scriptParentParent.Cryo)
local React = require(scriptParentParent.React)
local Rodux = require(scriptParentParent.Rodux)
local RoactRodux = require(scriptParentParent.RoactRodux)
local UIBlox = require(scriptParentParent.UIBlox)
local Foundation = require(scriptParentParent.Foundation)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local RobloxAppEnums = require(scriptParentParent.RobloxAppEnums)
local ReactFocusNavigation = require(scriptParentParent.ReactFocusNavigation)
local Provider = require(scriptParentParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local DeviceType = RobloxAppEnums.DeviceType
local GamepadDisconnectTokenMapper = require(scriptParentParent.InputUi).Gamepad.GamepadDisconnectTokenMapper
local FeedbackManagerInjectionContextProvider = require(scriptParentParent.InteractionFeedback).FeedbackManagerInjectionContextProvider

local AppInteractionFeedbackProvider = require(scriptParentParent.RobloxAppInteractionFeedbackConfig).AppInteractionFeedbackProvider

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

local tbl1 = {
    themeName = "dark",
    fontName = "gotham",
    deviceType = if isTenFootInterface() then DeviceType.Console else DeviceType.Desktop
}

local function CoreScriptsRootProvider(tbl2)
    local style = Cryo.Dictionary.join(tbl1, tbl2.styleOverride or {})

    local tree = React.createElement(RoactRodux.StoreProvider, {
        store = Rodux.Store.new(function<T>(arg1: T): T
            return arg1
        end, {}, {})
    }, {
        AppStyleProvider = React.createElement(UIBlox.App.Style.AppStyleProvider, { style = style }, {
            DesignTokenProvider = React.createElement(
                DesignTokenProvider,
                {
                    tokenMappers = { GamepadDisconnect = GamepadDisconnectTokenMapper }
                },
                {
                    CursorProvider = React.createElement(SelectionCursorProvider, {}, {
                        LocalizationProvider = React.createElement(
                            LocalizationProvider,
                            {
                                localization = Localization.new(LocalizationService.RobloxLocaleId)
                            },
                            {
                                FocusNavigationProvider = React.createElement(
                                    ReactFocusNavigation.FocusNavigationContext.Provider,
                                    { value = focusNavigationService },
                                    {
                                        FocusNavigationRegistryProvider = React.createElement(Provider, nil, tbl2.children)
                                    }
                                )
                            }
                        )
                    })
                }
            )
        })
    })
    local element = React.createElement(Foundation.FoundationProvider, {
        colorMode = if style.themeName == "dark" then Foundation.Enums.ColorMode.Dark else Foundation.Enums.ColorMode.Light,
        device = if style.deviceType == DeviceType.Console then Foundation.Enums.Device.Console else Foundation.Enums.Device.Desktop
    }, { tree = tree })

    return (React.createElement(
        AppInteractionFeedbackProvider,
        {},
        {
            tree = React.createElement(FeedbackManagerInjectionContextProvider, nil, { tree = element })
        }
    ))
end

return CoreScriptsRootProvider
