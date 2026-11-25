-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local LocalizationService = game:GetService("LocalizationService")
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Roact = PurchasePromptDeps.Roact
local Rodux = PurchasePromptDeps.Rodux
local RoactRodux = PurchasePromptDeps.RoactRodux
local LocaleProvider = require(PurchasePromptParent.IAPExperience).Locale.LocaleProvider

local LayoutValuesProvider = require(PurchasePrompt.Components.Connection.LayoutValuesProvider)
local LocalizationContextProvider = require(PurchasePrompt.Components.Connection.LocalizationContextProvider)
local Reducer = require(PurchasePrompt.Reducers.Reducer)
local LayoutValues = require(PurchasePrompt.Services.LayoutValues)
local StyleProviderWithDefaultTheme = require(PurchasePromptParent.Style).StyleProviderWithDefaultTheme

local Localization = require(PurchasePromptParent.RobloxAppLocales).Localization

local var1 = Roact.Component:extend("UnitTestContainer")

function var1.init(arg1)
    arg1.layoutValues = LayoutValues.new(false).layout
    arg1.store = arg1.props.overrideStore or Rodux.Store.new(Reducer, {})

    local var2 = arg1.props.overrideLocale or LocalizationService.RobloxLocaleId
    arg1.localizationContext = Localization.new(var2)
end

function var1.render(arg1)
    assert(
        not (arg1.props[Roact.Children] == nil) and #arg1.props[Roact.Children] > 0,
        "UnitTestContainer: no children provided, nothing will be tested"
    )

    return Roact.createElement(RoactRodux.StoreProvider, {
        store = arg1.store
    }, {
        LocaleProvider = Roact.createElement(LocaleProvider, {
            locale = LocalizationService.RobloxLocaleId
        }, {
            StyleProvider = Roact.createElement(StyleProviderWithDefaultTheme, {
                LocalizationContextProvider = Roact.createElement(LocalizationContextProvider, {
                    localizationContext = arg1.localizationContext,
                    render = function()
                        return Roact.createElement(LayoutValuesProvider, {
                            isTenFootInterface = false,
                            render = function()
                                return Roact.createElement("ScreenGui", { AutoLocalize = false, IgnoreGuiInset = true }, arg1.props[Roact.Children])
                            end
                        })
                    end
                })
            })
        })
    })
end

return var1
