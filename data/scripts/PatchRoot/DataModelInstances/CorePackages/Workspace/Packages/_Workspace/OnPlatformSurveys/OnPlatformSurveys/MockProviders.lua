-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveysParent = script:FindFirstAncestor("OnPlatformSurveys").Parent

local Localization = require(OnPlatformSurveysParent.Localization)
local React = require(OnPlatformSurveysParent.React)
local RoactRodux = require(OnPlatformSurveysParent.RoactRodux)
local RoactUtils = require(OnPlatformSurveysParent.RoactUtils)
local Rodux = require(OnPlatformSurveysParent.Rodux)
local Style = require(OnPlatformSurveysParent.Style)
local UIBlox = require(OnPlatformSurveysParent.UIBlox)
local UniversalAppPolicy = require(OnPlatformSurveysParent.UniversalAppPolicy)

local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies
local LayerCollectorProvider = UIBlox.Core.Layout.LayerCollector.LayerCollectorProvider
local LocalizationProvider = Localization.LocalizationProvider
local ProviderContainer = RoactUtils.Components.ProviderContainer
local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme

local function reducer(arg1)
    return arg1 or {}
end

local function MockProviders(tbl1)
    local providers = {}

    local store = Rodux.Store.new(reducer, {}, { Rodux.thunkMiddleware })

    table.insert(providers, { class = StyleProviderWithDefaultTheme, props = { withDarkTheme = true } })

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

    table.insert(providers, { class = LayerCollectorProvider, props = {} })

    table.insert(providers, { class = RoactRodux.StoreProvider, props = { store = store } })

    table.insert(providers, { class = RoactAppPolicy.Provider, props = { policy = { AppFeaturePolicies } } })

    return React.createElement(ProviderContainer, { providers = providers }, tbl1.children)
end

return MockProviders
