-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local dependencies = require(scriptParent.dependencies)
local ToastNotificationWrapper = require(scriptParent.ToastNotificationWrapper)
local React = dependencies.React
local ReactRoblox = dependencies.ReactRoblox
local _type = require(scriptParent.type)
local StyleProviderWithDefaultTheme = require(scriptParentParent.Style).StyleProviderWithDefaultTheme
local Foundation = require(scriptParentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local Localization = require(scriptParentParent.RobloxAppLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider

local ReactFocusNavigation = require(scriptParentParent.ReactFocusNavigation)

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
local Provider = require(scriptParentParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider

local InGameToastNotificationActionEventReceiver = require(script.Parent.InGameToastNotificationActionEventReceiver)
local SecurityAlertEventReceiver = require(script.Parent.receivers.SecurityAlertEventReceiver)
local engineFeature = game:GetEngineFeature("ClientToastNotificationsEnabled")
local GetFFlagEnableSecurityAlertToastCallback = require(scriptParentParent.SharedFlags).GetFFlagEnableSecurityAlertToastCallback

return function(tbl1)
    local toastNotification = Instance.new("Folder")
    toastNotification.Name = "ToastNotification"
    toastNotification.Parent = CoreGui
    local element

    if engineFeature then
        local createElement = React.createElement
        local var1 = FoundationProvider
        local tbl2 = {
            colorMode = Foundation.Enums.ColorMode.Dark
        }
        local tbl3 = { StyleProvider = 0 }
        local createElement2 = React.createElement
        local var2 = StyleProviderWithDefaultTheme
        local tbl4 = { withUiModeSupport = false, withDarkTheme = true }

        local tbl5 = { LocalizationProvider = 0 }
        local createElement3 = React.createElement
        local var3 = LocalizationProvider
        local tbl6 = {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        }
        local tbl7 = { FocusNavigationProvider = 0 }
        local createElement4 = React.createElement
        local provider = ReactFocusNavigation.FocusNavigationContext.Provider
        local tbl8 = { value = focusNavigationService }

        local tbl9 = {
            FocusNavigationRegistryProvider = React.createElement(Provider, nil, {
                React.createElement(InGameToastNotificationActionEventReceiver),
                SecurityAlertEventReceiver = if GetFFlagEnableSecurityAlertToastCallback() then React.createElement(SecurityAlertEventReceiver) else nil,
                ToastNotificationWrapper = React.createElement(ToastNotificationWrapper, { displayOrder = 13, renderLocation = tbl1.renderLocation })
            })
        }
        tbl7.FocusNavigationProvider = createElement4(provider, tbl8, tbl9)
        tbl5.LocalizationProvider = createElement3(var3, tbl6, tbl7)
        tbl3.StyleProvider = createElement2(var2, tbl4, tbl5)
        element = createElement(var1, tbl2, tbl3)
    else
        element = React.createElement(StyleProviderWithDefaultTheme, {
            withUiModeSupport = false,
            withDarkTheme = true
        }, {
            LocalizationProvider = React.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    ToastNotificationWrapper = React.createElement(ToastNotificationWrapper, { displayOrder = 13, renderLocation = tbl1.renderLocation }),
                    InGameToastNotificationActionEventReceiver = React.createElement(InGameToastNotificationActionEventReceiver)
                }
            )
        })
    end
    ReactRoblox.createRoot(toastNotification):render(element)
end
