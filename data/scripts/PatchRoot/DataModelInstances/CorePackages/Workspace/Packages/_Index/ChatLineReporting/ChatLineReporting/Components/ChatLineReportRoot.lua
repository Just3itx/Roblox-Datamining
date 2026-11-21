-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent
local CoreGui = game:GetService("CoreGui")

local Provider = require(ChatLineReportingParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local LocalizationService = game:GetService("LocalizationService")
local Localization = require(ChatLineReportingParent.InExperienceLocales).Localization
local LocalizationProvider = require(ChatLineReportingParent.Localization).LocalizationProvider
local React = require(ChatLineReportingParent.React)
local ReactFocusNavigation = require(ChatLineReportingParent.ReactFocusNavigation)
local Roact = require(ChatLineReportingParent.Roact)
local StyleProviderWithDefaultTheme = require(ChatLineReportingParent.Style).StyleProviderWithDefaultTheme
local LayerCollectorProvider = require(ChatLineReportingParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider

local ChatLineReportStepHandler = require(ChatLineReporting.Components.ChatLineReportStepHandler)

local FoundationProvider = require(ChatLineReportingParent.Foundation).FoundationProvider

local focusNavigationService = nil
local var1 = nil

local function unmount()
    if var1 then
        Roact.unmount(var1)
        focusNavigationService:teardown()
    end
end

return {
    initialize = function(messages)
        local chatLineReportRoot = React.createElement(
            "ScreenGui",
            {
                IgnoreGuiInset = true,
                OnTopOfCoreBlur = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            },
            {
                LayerCollector = React.createElement(LayerCollectorProvider, {}, {
                    LocalizationProvider = Roact.createElement(
                        LocalizationProvider,
                        {
                            localization = Localization.new(LocalizationService.RobloxLocaleId)
                        },
                        {
                            FoundationProvider = React.createElement(FoundationProvider, {
                                colorMode = "Dark"
                            }, {
                                StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {
                                    withDarkTheme = true
                                }, {
                                    ChatLineReportStepHandler = React.createElement(ChatLineReportStepHandler, { unmount = unmount, messages = messages })
                                })
                            })
                        }
                    )
                })
            }
        )
        focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

        var1 = Roact.mount(
            React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = focusNavigationService },
                {
                    FocusNavigationRegistryProvider = React.createElement(Provider, nil, { ChatLineReportRoot = chatLineReportRoot })
                }
            ),
            CoreGui,
            "ChatLineReportRoot"
        )
    end
}
