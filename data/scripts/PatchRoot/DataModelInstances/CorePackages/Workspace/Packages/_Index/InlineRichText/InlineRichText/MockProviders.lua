-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichTextParent = script:FindFirstAncestor("InlineRichText").Parent
local React = require(InlineRichTextParent.React)
local ProviderContainer = require(InlineRichTextParent.RoactUtils).Components.ProviderContainer
local Style = require(InlineRichTextParent.Style)
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local FoundationProvider = require(InlineRichTextParent.Foundation).FoundationProvider
local Cryo = require(InlineRichTextParent.Cryo)
local Rodux = require(InlineRichTextParent.Rodux)
local RoactRodux = require(InlineRichTextParent.RoactRodux)
local LocalizationProvider = require(InlineRichTextParent.Localization).LocalizationProvider
local NavigationRodux = require(InlineRichTextParent.NavigationRodux)

local tbl1 = { withUiModeSupport = false }

local function MockProviders(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local providers = {}

    table.insert(providers, { class = FoundationProvider, props = { device = "Desktop", theme = var1.themeName } })

    table.insert(providers, {
        class = RoactRodux.StoreProvider,
        props = {
            store = Rodux.Store.new(function<T>(arg1: T, _): T
                return arg1
            end, {
                Navigation = { lockNavigationActions = false }
            }, {
                Rodux.thunkMiddleware,
                NavigationRodux.Thunks.RNAdapterThunk.middleware(function(arg1)
                    print(`[Mock Providers Debug] Navigating to {arg1.routeName} with detail {arg1.params.detail}`)
                end)
            })
        }
    })

    table.insert(providers, {
        class = StyleProviderWithDefaultTheme,
        props = {
            withDarkTheme = var1.themeName ~= "Light",
            withUiModeSupport = var1.withUiModeSupport
        }
    })

    table.insert(providers, { class = Style.DesignTokenProvider, props = { tokenMappers = {} } })

    table.insert(providers, {
        class = LocalizationProvider,
        props = {
            localization = {
                Format = function(_, str1: string): string
                    return str1
                end
            }
        }
    })

    return React.createElement(ProviderContainer, { providers = providers }, var1.children)
end

return MockProviders
